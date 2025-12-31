# 10-julia-magic.py
#
# Runs once at Python kernel startup.
# Provides:
#   - %%julia cell magic
#   - automatic GenLinAlgProblems activation
#   - l_show(...) that renders LaTeX in both Julia and Python contexts

from IPython.core.magic import register_cell_magic
from IPython.display import display
from juliacall import Main as jl


# ------------------------------------------------------------------
# Activate GenLinAlgProblems ONCE
# ------------------------------------------------------------------

jl.seval("""
using Pkg
Pkg.activate("/home/jovyan/elementary-linear-algebra/GenLinAlgProblems")
using GenLinAlgProblems
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

# Override l_show in Main (not in the package!)
function l_show(args...; kwargs...)
    __init_l_show__()
    latex_string = GenLinAlgProblems.L_show(args...; kwargs...)
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
    calls Julia's l_show and displays the result.
    """
    return display(jl.l_show(*args, **kwargs))


# ------------------------------------------------------------------
# %%julia cell magic
# ------------------------------------------------------------------

@register_cell_magic
def julia(line, cell):
    """
    Execute Julia code in the Python kernel.
    """
    return jl.seval(cell)

