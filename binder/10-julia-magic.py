# 10-julia-magic.py
#
# Runs once at Python kernel startup.
# Provides:
#   - %%julia cell magic
#   - automatic LAlatex activation
#   - l_show(...) that renders LaTeX in both Julia and Python contexts

import os

from IPython.core.magic import register_cell_magic
from IPython.display import Latex, display

os.environ.setdefault("JULIA_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIACALL_PROJECT", "/home/jovyan/.julia_env")


from juliacall import Main as jl


# ------------------------------------------------------------------
# Julia helpers (LAlatex is opt-in)
# ------------------------------------------------------------------

jl.seval("""
using PythonCall
""")


# ------------------------------------------------------------------
# Define Julia-side l_show for %%julia cells
# ------------------------------------------------------------------

jl.seval("""
# Cache Python display machinery (Julia side)
const _ip_display = Ref{Any}(nothing)
const _ip_latex   = Ref{Any}(nothing)

function __init_l_show__()
    if _ip_display[] === nothing
        ip = pyimport("IPython.display")
        _ip_display[] = ip.display
        _ip_latex[]   = ip.Latex
    end
    nothing
end

function _require_lalatex()
    if !isdefined(Main, :LAlatex)
        error("LAlatex not loaded. Run `using LAlatex` first.")
    end
    nothing
end

# Provide L_show and l_show in Main (not in the package!)
function L_show(args...; kwargs...)
    _require_lalatex()
    return Main.LAlatex.L_show(args...; kwargs...)
end

function l_show(args...; kwargs...)
    __init_l_show__()
    latex_string = L_show(args...; kwargs...)
    _ip_display[](_ip_latex[](latex_string))
    nothing
end
""")


# ------------------------------------------------------------------
# Python-side l_show for normal Python cells
# ------------------------------------------------------------------

def l_show(*args, **kwargs):
    """
    Python-side l_show:
    calls Julia's L_show and displays the result.
    """
    latex_string = jl.L_show(*args, **kwargs)
    return display(Latex(latex_string))


# ------------------------------------------------------------------
# %%julia cell magic
# ------------------------------------------------------------------

@register_cell_magic
def julia(line, cell):
    """
    Execute Julia code in the Python kernel.
    """
    return jl.seval(cell)
