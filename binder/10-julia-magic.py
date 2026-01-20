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

from IPython.core.magic import register_cell_magic
from IPython.display import Latex, display

os.environ.setdefault("JULIA_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIACALL_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("PYJULIAPKG_PROJECT", "/home/jovyan/.julia_env")


from juliacall import Main as jl


# ------------------------------------------------------------------
# Julia helpers (LAlatex is opt-in)
# ------------------------------------------------------------------

jl.seval("""
using PythonCall
""")

jl.seval("""
import Pkg
Pkg.activate("/home/jovyan/.julia_env")
""")


# ------------------------------------------------------------------
# Python-side l_show for normal Python cells
# ------------------------------------------------------------------

def l_show(*args, **kwargs):
    """
    Python-side l_show:
    calls Julia's L_show and displays the result.
    """
    latex_string = jl.LAlatex.L_show(*_convert_args(args), **kwargs)
    return display(Latex(latex_string))


# Make jl.l_show render via Python when called from a Python kernel.
setattr(jl, "l_show", l_show)


def _convert_args(args):
    converted = []
    for arg in args:
        converted.append(_maybe_to_julia_array(arg))
    return tuple(converted)


def _maybe_to_julia_array(value):
    if _is_2d_list(value):
        return _list_to_julia_matrix(value)
    return value


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


# ------------------------------------------------------------------
# %%julia cell magic
# ------------------------------------------------------------------

@register_cell_magic
def julia(line, cell):
    """
    Execute Julia code in the Python kernel.
    """
    cell = re.sub(r'^\s*using\s+LAlatex\s*$', 'import LAlatex', cell, flags=re.MULTILINE)
    cell = re.sub(r'(?<![\w\.])l_show\(', 'LAlatex.l_show(', cell)
    return jl.seval(cell)
