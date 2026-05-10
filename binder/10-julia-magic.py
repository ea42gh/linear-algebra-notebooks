# 10-julia-magic.py
#
# Runs once at Python kernel startup.
# Provides:
#   - %%julia cell magic
#   - automatic LAlatex activation
#   - l_show(...) that renders LaTeX in both Julia and Python contexts

import os
import re
from numbers import Number

from IPython import get_ipython
from IPython.display import Latex, Math, display

os.environ.setdefault("JULIA_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIACALL_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("PYTHON_JULIACALL_EXE", "/usr/local/julia/bin/julia")
os.environ.setdefault("PYTHON_JULIACALL_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("PYJULIAPKG_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIAPKG_PROJECT", "/home/jovyan/.julia_env")


from juliacall import Main as jl


# ------------------------------------------------------------------
# Julia helpers (LAlatex is opt-in)
# ------------------------------------------------------------------

jl.seval("""
import Pkg
Pkg.activate("/home/jovyan/.julia_env")
""")

jl.seval("""
using PythonCall
""")

jl.seval("""
import PythonCall
const _py_display = PythonCall.pyimport("IPython.display")
function _py_display_latex(x)
    s = String(x)
    if startswith(strip(s), "$")
        inner = strip(s)[2:end-1]
        _py_display.display(_py_display.Math(inner))
    else
        _py_display.display(_py_display.Latex(s))
    end
    return x
end
""")

jl.seval("""
using LAlatex, GenLAProblems, LinearAlgebra, BlockArrays, RowEchelon, LaTeXStrings, Latexify, Random
""")

_JL_LATEXSTRING = jl.seval("LaTeXString")

# ------------------------------------------------------------------
# Python-side l_show for normal Python cells
# ------------------------------------------------------------------

class RawLatex(str):
    """Marker for strings that should be passed to Julia as LaTeXString."""

    _lalatex_raw_latex = True


def L(value):
    """Wrap a Python string as raw LaTeX for the l_show helper."""
    return RawLatex(value)


def L_show(*args, **kwargs):
    """
    Python-side L_show:
    calls Julia's L_show and returns the raw LaTeX string.
    """
    return str(jl.LAlatex.L_show(*_convert_args(args), **kwargs))


def l_show(*args, **kwargs):
    """
    Python-side l_show:
    calls Julia's L_show and displays the result.
    """
    raw = L_show(*args, **kwargs)
    raw = raw.replace("\\text{", "\\mathrm{")
    raw = _mathjax_text_fallback(raw)
    display(Latex(raw))
    return None

 # Avoid binding jl.l_show into Julia Main to prevent conflicts with LAlatex.


def _convert_args(args):
    converted = []
    for arg in args:
        converted.append(_convert_arg(arg))
    return tuple(converted)


def _convert_arg(value):
    if _is_raw_latex(value):
        return _JL_LATEXSTRING(str(value))
    if _is_2d_list(value):
        return _list_to_julia_matrix(value)
    return value


def _is_raw_latex(value):
    return isinstance(value, RawLatex) or bool(getattr(value, "_lalatex_raw_latex", False))


def _is_2d_list(value):
    if not isinstance(value, (list, tuple)) or not value:
        return False
    if not all(isinstance(row, (list, tuple)) for row in value):
        return False
    row_len = len(value[0])
    if row_len == 0:
        return False
    for row in value:
        if len(row) != row_len:
            return False
        if not all(isinstance(item, Number) for item in row):
            return False
    return True


def _list_to_julia_matrix(value):
    rows = []
    for row in value:
        rows.append(" ".join(_format_julia_number(item) for item in row))
    expr = "[" + "; ".join(rows) + "]"
    return jl.seval(expr)


def _format_julia_number(value):
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        return repr(value)
    if isinstance(value, complex):
        re_part = _format_julia_number(value.real)
        im_part = _format_julia_number(abs(value.imag))
        sign = "+" if value.imag >= 0 else "-"
        return f"{re_part} {sign} {im_part}*im"
    return str(value)


def _mathjax_text_fallback(latex_string):
    def replace_text(match):
        content = match.group(1)
        content = content.replace("\\", "\\\\")
        content = content.replace(" ", "\\,")
        return "\\mathrm{" + content + "}"
    return re.sub(r"\\\\?text\\{([^{}]*)\\}", replace_text, latex_string)


# ------------------------------------------------------------------
# %%julia cell magic
# ------------------------------------------------------------------

def julia(line, cell):
    """
    Execute Julia code in the Python kernel.
    """
    cell = re.sub(r'^\s*using\s+LAlatex\s*$', 'import LAlatex', cell, flags=re.MULTILINE)
    cell = re.sub(r'(?<![\w\.])l_show\(', 'LAlatex.L_show(', cell)
    cell = re.sub(r'(?<![\w\.])display\(', '_py_display_latex(', cell)
    if 'L"' in cell or '@L_str' in cell:
        jl.seval("using LaTeXStrings")
    wrapped = "begin\n" + cell + "\n; nothing\nend"
    return jl.seval(wrapped)


ip = get_ipython()
if ip is not None:
    ip.register_magic_function(julia, "cell", "julia")
