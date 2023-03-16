#using LinearAlgebra, Latexify

# ------------------------------------------------------------------------------
# ------------------------------------------ apply function to stack of matrices
# ------------------------------------------------------------------------------
function apply_function( f, matrices)
    function fm(mat)
        if mat == :none return :none end
        f.(mat)
    end
    [ [ fm(mat) for mat in level ] for level in matrices ]
end
# ------------------------------------------------------------------------------
# -------------------------- factor out a denominator from an array of Rationals
# ------------------------------------------------------------------------------
function factor_out_denominator( A )
    1, A
end
# ------------------------------------------------------------------------------
function factor_out_denominator( A::Array{Rational{Int64},2} )
    d = reduce( lcm, denominator.(A) )
    d, Int64.(d*A)
end
# ------------------------------------------------------------------------------
# --------------------------------------------- convert to latex, print np_array
# ------------------------------------------------------------------------------
function print_np_array_def(A)
    M,N=size(A)
    println("A = np.array([")
    for i in 1:M
        print("[")
        for j in 1:(N-1)
            print(" ", A[i,j], ",")
        end
        println(" ", A[i, N], "],")
    end
    println("])")
end
# ------------------------------------------------------------------------------
to_latex(x) = latexify(x)
# ------------------------------------------------------------------------------
function to_latex(x::Real)
    if x < 0  # fix up minus signs
        replace( "-"*latexify(-x), "\$"=>"")
    else
        replace( latexify(x), "\$"=>"")
    end
end
# ------------------------------------------------------------------------------
function to_latex(x::SymPy.Sym)
    replace( latexify(x), "\$"=>"")
end
# ------------------------------------------------------------------------------
function to_latex(x::Real)
    if x < 0  # fix up minus signs
        replace( "-"*latexify(-x), "\$"=>"")
    else
        replace( latexify(x), "\$"=>"")
    end
end
# ------------------------------------------------------------------------------
function to_latex(x::Complex)
    if imag(x) == 0
        return to_latex(real(x))
    else
        if real(x) == 0
            return to_latex(imag(x))*"\\mathit{i}"
        elseif imag(x) < 0
            return to_latex(real(x))*" - " * to_latex(-imag(x))*"\\mathit{i}"
        else
            return to_latex(real(x))*" + " * to_latex( imag(x))*"\\mathit{i}"
        end
    end
end
# ------------------------------------------------------------------------------
function to_latex(matrices::Vector)
    apply_function( to_latex, matrices)
end
# -------------------------------------------------------------------------------
# -------------------------------------------------- rounding a stack of matrices
# -------------------------------------------------------------------------------
function round_value(x, digits)
    v = round( x, digits=digits )
    vd,vi=modf(v)
    if iszero(vd) v = Int(vi) end
    v
end
# -------------------------------------------------------------------------------
function round_value(x::Complex, digits)
    Complex( round_value(real(x), digits), round_value(imag(x), digits) )
end
# ------------------------------------------------------------------------------
function round_matrices( matrices, digits )
    apply_function( x->round_value(x,digits), matrices)
end
# ==============================================================================
