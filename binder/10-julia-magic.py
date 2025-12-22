from IPython.core.magic import register_cell_magic
from juliacall import Main as jl

# Activate GenLinAlgProblems ONCE
jl.seval("""
using Pkg
Pkg.activate("/home/jovyan/elementary-linear-algebra/GenLinAlgProblems")
""")

@register_cell_magic
def julia(line, cell):
    return jl.seval(cell)

