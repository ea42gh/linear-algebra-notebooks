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
function factor_out_denominator( A::Vector{Rational{Int}} )
    d = reduce( lcm, denominator.(Vector(A)) )
    d, Int64.(d*A)
end
# ------------------------------------------------------------------------------
function factor_out_denominator( A::Array{Rational{Int64},2} )
    d = reduce( lcm, denominator.(Matrix(A)) )
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
function to_latex(x::SymPy.Sym)
    replace( latexify(x), "\$"=>"")
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
function latex(s::String) LaTeXStrings.LaTeXString(s) end

"convert arguments to a LaTeX expression. Display in notebook with LaTeXString(L_show(...))"
function L_show(
    args...;  # Accepts a variable number of arguments
    arraystyle       = :curlyarray,  # :curly, :round, :square, or other styles
    color            = nothing,      # Optional color for LaTeX text
    number_formatter = nothing,      # Optional function to format numbers
    inline           = true          # Whether to return inline or block LaTeX
)
    # Helper function to apply optional LaTeX styling
    style_wrapper(content::String) = begin
        color_str = color !== nothing ? "\\textcolor{$color}{" : ""
        prefix    = color_str
        suffix    = (color !== nothing ? "}" : "")
        "$prefix$content$suffix"
    end

    # Helper function to format individual entries
    f(x) =
        x isa SymPy.Sym     ? replace(latexify(x), "\$" => "") : # Handle SymPy symbolic entries
        x isa Sym{PyObject} ? replace(latexify(x), "\$" => "") : # Handle Sym{PyObject} entries
        x isa String        ? replace(x, "_" => "\\_")         :
        x isa LaTeXString   ? strip(string(x), ['$', '\n'])    : # Remove $...$ from LaTeXString
        x isa Rational      ? "\\frac{$(numerator(x))}{$(denominator(x))}" : # Handle Rational numbers
        x isa Complex       ? format_complex(x) :
        x isa Number        ? (number_formatter !== nothing ? number_formatter(x) : string(x)) :
        error("Unsupported type: $(typeof(x))")

    # Helper function to format Complex numbers
    function format_complex(c::Complex)
        real_part = f(real(c))
        imag_val = imag(c)

        if imag_val == 0         return real_part
        elseif imag_val == 1     return "$real_part + \\mathrm{i}"
        elseif imag_val == -1    return "$real_part - \\mathrm{i}"
        else
            imag_part = f(abs(imag_val))
            imag_sign = imag_val > 0 ? "+" : "-"
            return "$real_part $imag_sign $imag_part \\mathrm{i}"
        end
    end
    function format_complex(c::Complex{Rational{Int}})
        real_part = f(real(c))
        imag_val  = imag(c)

        if     imag_val ==  0 return real_part
        elseif imag_val ==  1 return "$real_part + \\mathrm{i}"
        elseif imag_val == -1 return "$real_part - \\mathrm{i}"
        else
            imag_part = f(abs(imag_val))
            imag_sign = imag_val > 0 ? "+" : "-"
            return "$real_part $imag_sign $imag_part \\mathrm{i}"
        end
    end

    # Helper function to handle Rational{Int} arrays
    function process_rational_array(A::AbstractArray{Rational{Int}})
        d, intA = factor_out_denominator(A)
        if d == 1
            return "", intA
        else
            return 1//d, intA
        end
    end

    # Helper function to handle matrices
    function latex_matrix(mat::AbstractMatrix; arraystyle=:curlyarray)
        if isempty(mat) return "\\emptyset" end
    
        env = arraystyle == :round      ? "bmatrix" :  # Round brackets
              arraystyle == :square     ? "Bmatrix" :  # Square brackets
              arraystyle == :curly      ? "pmatrix" :  # Curly braces (parentheses)
              arraystyle == :curlyarray ? "array"   :  # Curly array format
              "bmatrix"                               # Default to round brackets
    
        # Handle Rational{Int} matrices separately (factor out denominator)
        if eltype(mat) == Rational{Int}
            factor, int_mat = process_rational_array(mat)
            factor_str = f(factor)  # Safe since factor is a single number
            rows = [join(f.(row), " & ") for row in eachrow(int_mat)]  # FIXED: Apply f element-wise
        else
            factor_str = ""
            rows = [join(f.(row), " & ") for row in eachrow(mat)]  # FIXED: Apply f element-wise
        end
    
        # Ensure correct handling of integer and complex elements
        if eltype(mat) <: Integer || eltype(mat) <: Complex
            rows = [join(f.(row), " & ") for row in eachrow(mat)]  # FIXED: Apply f element-wise
        end
    
        # LaTeX matrix formatting
        matrix_str = if arraystyle == :curlyarray
            "\\left(\\begin{array}{" * "r"^size(mat,2) * "}\n" *
            join(rows, " \\\\\n") * "\n\\end{array}\\right)"
        else
            "\\begin{$env}\n" * join(rows, " \\\\\n") * "\n\\end{$env}"
        end
    
        return isempty(factor_str) ? matrix_str : "$factor_str \\cdot $matrix_str"
    end
    
    # Helper function to handle vectors by converting them to column matrices
    function latex_vector(vec::AbstractVector; arraystyle=:round)
        latex_matrix(reshape(vec, :, 1); arraystyle=arraystyle)
    end

    # Map the input arguments to their LaTeX representations
    formatted_args = map(arg ->
        arg isa AbstractVector ? latex_vector(arg, arraystyle=arraystyle) :
        arg isa AbstractMatrix ? latex_matrix(arg, arraystyle=arraystyle) :
        f(arg), args)

    # Combine formatted arguments into a single LaTeX string
    styled_content = join(formatted_args, " ")

    # Apply the style wrapper to the entire content
    styled_content = style_wrapper(styled_content)

    # Wrap content as inline or block LaTeX
    if inline
        return "\$"  * styled_content * "\$\n"   # Inline wrapping
    else
        return "\\[" * styled_content * "\\]\n"  # Block-style wrapping
    end
end


"convert arguments to a LaTeX expression. directly display in notebook"
function l_show(args...; kwargs...)
     LaTeXString(L_show(args...; kwargs... ))
end


# Wrapper for Python's LaTeX rendering: use from julia in Python notebook
function py_show(args...; kwargs...)
    py_display = pyimport("IPython.display").display
    py_latex   = pyimport("IPython.display").Latex
    latex_string = L_show(args...; kwargs...)
    py_display(py_latex(latex_string))
end
