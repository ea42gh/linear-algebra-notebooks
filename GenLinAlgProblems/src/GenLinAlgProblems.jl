module GenLinAlgProblems
using PyCall
#itikz = pyimport("itikz")
#nM    = pyimport("itikz.nicematrix")

const py_itikz  = PyNULL()
const nM     = PyNULL()
function __init__()
  copy!(py_itikz, pyimport( "itikz"))
  copy!(nM,    pyimport( "itikz.nicematrix"))
end
export py_itikz, nM

using AbstractAlgebra, LinearAlgebra, Latexify, LaTeXStrings, SymPy
using Random, Hadamard

# general utility
function Base.adjoint(s::LaTeXString) s end
function Base.adjoint(s::String) s end
function Base.adjoint(p::AbstractAlgebra.Generic.Poly{Rational{BigInt}}) p end

export apply_function, factor_out_denominator
export latex, to_latex, print_np_array_def
export round_value, round_matrices


# matrices for GE and GJ
export unit_lower, lower, gen_full_col_rank_matrix
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
export gram_schmidt_w, qr_layout, gram_schmidt_stable

# eigenproblems
export gen_eigenproblem, gen_symmetric_eigenproblem, gen_non_diagonalizable_eigenproblem, gen_svd_problem
export gen_cx_eigenproblem 
export jordan_block, jordan_form, gen_from_jordan_form
export charpoly
# display stuff
export ge, show_solution
export ShowGe, ref!, show_layout!, show_system, create_cascade!, show_backsubstitution!, solutions
export to_html, show_html, pr

include("LatexRepresentations.jl")
include("MatrixGeneration.jl")
include("SolveProblems.jl")
include("show_html.jl")
include("ge.jl")
end # module GenLinAlgProblems
