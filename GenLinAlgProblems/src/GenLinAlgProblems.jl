module GenLinAlgProblems
using PythonCall
using IOCapture
using Symbolics

export py_show   # for use in julia cell of Python notebook

const _itikz   = Ref{Any}(nothing)
const _nM      = Ref{Any}(nothing)
const _sympy   = Ref{Any}(nothing)

const NO_VALUE = (:none, nothing)
is_none_val(x) = x === :none || x === nothing

function load_sympy()
    if _sympy[] === nothing
        try
            _sympy[] = pyimport("sympy")
        catch err
            error(
                "Python module `sympy` is required by GenLinAlgProblems.\n" *
                "It should be provided via CondaPkg.toml.\n\n" *
                "Original error:\n$err"
            )
        end
    end
    return _sympy[]
end

function load_itikz()
    if _itikz[] === nothing
        try
            _itikz[] = pyimport("itikz")
            _nM[]    = pyimport("itikz.nicematrix")
        catch err
            error(
                "Python module `itikz` (and `itikz.nicematrix`) is required by GenLinAlgProblems.\n" *
                "It should be provided via CondaPkg.toml.\n\n" *
                "Original error:\n$err"
            )
        end
    end
    return _itikz[], _nM[]
end

using AbstractAlgebra, BlockArrays, SparseArrays, LinearAlgebra, Latexify, LaTeXStrings
using Random, Hadamard

using PythonCall
#sympy = nothing
#itikz = nothing
#nM    = nothing
#
#function __init__()
#    global sympy = _load_sympy()
#    global itikz, nM = _load_itikz()
#    return nothing
#end

export load_sympy, load_itikz
# ---------------------------------------------------------------------------------
"""
    syms(names...; kwargs...)

Create one or more SymPy symbols.

Arguments are forwarded to `sympy.symbols`. Multiple names return a tuple.
Keyword arguments are passed directly to SymPy.

Examples
```julia
x = syms(:x)
x, y = syms(:x, :y; real=true)
"""
syms(names...; kwargs...) = sympy.symbols(names...; kwargs...)

# ---------------------------------------------------------------------------------
"""
    @syms x y z [(:key => value)...]

Create and bind SymPy symbols to Julia variables.

Options must be given as `key => value` pairs and apply to all symbols.

Examples
```julia
@syms x y
@syms x y (:real => true)
Use syms(:x, :y; ...) for normal keyword syntax.
"""
macro syms(args...)
    vars = filter(x -> x isa Symbol, args)
    opts = filter(x -> x isa Expr && x.head == :(=>), args)

    assigns = Vector{Expr}()

    for v in vars
        if isempty(opts)
            push!(assigns,
                :( $(esc(v)) = SymPyHelpers.syms($(string(v))) )
            )
        else
            push!(assigns,
                :( $(esc(v)) = SymPyHelpers.syms($(string(v)); $(opts...)) )
            )
        end
    end

    Expr(:block, assigns...)
end

macro import_sympy(names...)
    assigns = [
        :( const $(esc(n)) = _load_sympy().$(n) )
        for n in names
    ]
    return Expr(:block, assigns...)
end

export syms, import_sympy
# general utility
# 🟢 Extend transpose and adjoint for Char, String, and LaTeXString
function Base.adjoint(p::AbstractAlgebra.Generic.Poly{Rational{BigInt}}) p end
function Base.transpose(p::AbstractAlgebra.Generic.Poly{Rational{BigInt}}) p end
Base.transpose(x::Char) = x
Base.adjoint(x::Char) = x

Base.transpose(x::String) = x
Base.adjoint(x::String) = x

Base.transpose(x::LaTeXString) = x
Base.adjoint(x::LaTeXString) = x

#Base.transpose(x::PythonCall.Py) = x
#Base.adjoint(x::PythonCall.Py) = x

export set, lc
export apply_function, factor_out_denominator
export l_show, L_show, latex, to_latex, print_np_array_def
export round_value, round_matrices

export bold_formatter, italic_formatter, color_formatter, conditional_color_formatter
export underline_formatter, overline_formatter, combine_formatters, scientific_formatter
export percentage_formatter, exponential_formatter
export tril_formatter, block_formatter, diagonal_blocks_formatter

export symbol_vector, symbols_matrix, form_linear_combination, L_interp

# matrices for GE and GJ
export invert_unit_lower, unit_lower, lower, gen_full_col_rank_matrix
export ref_matrix, rref_matrix, symmetric_matrix, skew_symmetric_matrix
export e_i, i_with_onecol
export gen_permutation_matrix

# matrices for GE and GJ
export W_2_matrix, Q_2_matrix
export W_3_matrix, Q_3_matrix
export Q_4_blocks
export W_4_matrix, Q_4_matrix
export W_matrix, Q_matrix, sparse_W_matrix, sparse_Q_matrix

# GE and GJ problems
export split_R_RHS, particular_solution, homogeneous_solutions
export gen_particular_solution
export gen_gj_matrix, gen_rhs, gen_gj_pb
export gen_inv_pb, gen_lu_pb, gen_plu_pb, gen_ldlt_pb

export normal_eq_reduce_to_ref, reduce_to_ref, decorate_ge, ge_variable_type

# normal equation and QR problems
export ca_projection_matrix
export gen_qr_problem_3, gen_qr_problem_4, gen_qr_problem
export gram_schmidt_w, normalize_columns, qr_layout, gram_schmidt_stable

# eigenproblems
export gen_eigenproblem, gen_symmetric_eigenproblem, gen_non_diagonalizable_eigenproblem, gen_svd_problem
export gen_cx_eigenproblem 
export jordan_block, jordan_form, gen_from_jordan_form, gen_degenerate_matrix
export charpoly

# display stuff
export ge, show_solution
export ShowGe, ref!, show_layout!, show_system, create_cascade!, show_backsubstitution!, show_solution!
export show_backsubstitution, show_forwardsubstitution, solutions
export to_html, show_html, pr
export capture_output, show_side_by_side

export factor_out_denominator

include("LatexRepresentations.jl")
include("MatrixGeneration.jl")
include("SolveProblems.jl")
include("show_html.jl")
include("ge.jl")
include("Formatters.jl")
end # module GenLinAlgProblems
