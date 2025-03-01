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
function factor_out_denominator(A::Vector{Complex{Rational{Int}}})
    # Extract denominators from real and imaginary parts
    denominators_real = denominator.(real.(A))
    denominators_imag = denominator.(imag.(A))

    # Compute the LCM of all denominators
    d = reduce(lcm, vcat(denominators_real, denominators_imag), init=1)

    # Multiply vector by LCM and convert to Complex{Int}
    A_int = Complex{Int64}.(d .* real.(A), d .* imag.(A))

    return d, A_int  # Return LCM and the scaled vector
end
# ------------------------------------------------------------------------------
function factor_out_denominator(A::Matrix{Complex{Rational{Int}}})
    denominators_real = denominator.(real.(A))
    denominators_imag = denominator.(imag.(A))

    d = reduce(lcm, vcat(denominators_real, denominators_imag), init=1)

    A_int = Complex{Int64}.(d .* real.(A), d .* imag.(A))

    return d, A_int  # Return LCM and the scaled matrix
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
to_latex(x; number_formatter=nothing) = latexify(x)
# ------------------------------------------------------------------------------
function to_latex(x::Real; number_formatter=nothing)
    # Apply number formatter if provided
    x = number_formatter !== nothing ? number_formatter(x) : x
    return x < 0 ? replace("-" * latexify(-x), "\$" => "") : replace(latexify(x), "\$" => "")
end
# ------------------------------------------------------------------------------
function to_latex(x::Rational{Int}; number_formatter=nothing)
    # Apply number formatter if provided (converts rational to float)
    if number_formatter !== nothing
        x = number_formatter(x)
        return to_latex(x; number_formatter=nothing)  # Re-call with new value
    end
    return denominator(x) == 1 ? string(numerator(x)) : "\\frac{$(numerator(x))}{$(denominator(x))}"
end
# ------------------------------------------------------------------------------
function to_latex(c::Complex; number_formatter=nothing)
    real_part = to_latex(real(c); number_formatter=number_formatter)
    imag_val = imag(c)
    imag_val = number_formatter !== nothing ? number_formatter(imag_val) : imag_val  # Apply formatter

    if imag_val == 0
        return real_part  # Pure real number
    elseif real(c) == 0
        return imag_val == 1 ? "\\mathit{i}" :
               imag_val == -1 ? "-\\mathit{i}" :
               to_latex(imag_val; number_formatter=number_formatter) * "\\mathit{i}"  # Pure imaginary
    else
        imag_sign = imag_val < 0 ? " - " : " + "
        imag_part = abs(imag_val) == 1 ? "\\mathit{i}" : to_latex(abs(imag_val); number_formatter=number_formatter) * "\\mathit{i}"
        return real_part * imag_sign * imag_part
    end
end
# ------------------------------------------------------------------------------
function to_latex(x::SymPy.Sym; number_formatter=nothing)
    latex_expr = replace(latexify(x), "\$" => "")  # Convert to LaTeX

    # Optionally evaluate the symbolic expression to a number, then apply formatter
    if number_formatter !== nothing
        try
            num_value = SymPy.N(x)  # Convert symbolic expression to a numerical value
            formatted_value = number_formatter(num_value)
            return to_latex(formatted_value; number_formatter=nothing)  # Convert to LaTeX after formatting
        catch
            return latex_expr  # If conversion fails, return symbolic LaTeX
        end
    else
        return latex_expr  # Default symbolic LaTeX conversion
    end
end
# ------------------------------------------------------------------------------
function to_latex(matrices::Vector; number_formatter=nothing)
    apply_function(x -> to_latex(x; number_formatter=number_formatter), matrices)
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
    # --------------------------------------------------------------------------
    # Helper function to format individual entries
    function f(x)
        x isa SymPy.Sym     ? replace(latexify(x), "\$" => "")                                 : # Handle SymPy symbolic entries
        x isa Sym{PyObject} ? replace(latexify(x), "\$" => "")                                 : # Handle Sym{PyObject} entries
        x isa String        ? "\\text{" * replace(x, "_" => "\\_") *"}"                        : # handle underscores
        x isa LaTeXString   ? strip(string(x), ['$', '\n'])                                    : # Remove $...$ from LaTeXString
        x isa Rational      ? to_latex(x;number_formatter=number_formatter)                    : # Handle Rational numbers
        x isa Complex       ? to_latex(x;number_formatter=number_formatter)                    : # Handle Complex Numbers
        x isa Number        ? (number_formatter !== nothing ? number_formatter(x) : string(x)) :
        error("Unsupported type: $(typeof(x))")
    end

    # --------------------------------------------------------------------------
    # Helper function to handle arrays
    function process_array(A)
        return "", A
    end
    function process_array(A::AbstractArray{Rational{Int}})
        d, intA = factor_out_denominator(A)
        return d == 1 ?  ("", intA) : ( 1//d, intA )
    end
    function process_array(A::AbstractArray{Complex{Rational{Int}}})
        d, intA = factor_out_denominator(A)
        return d == 1 ? ("", intA) : (1//d, intA)
    end

    # --------------------------------------------------------------------------
    # Helper function to handle matrices
    function latex_matrix(mat::AbstractMatrix; arraystyle=:curlyarray)
        if isempty(mat) return "\\emptyset" end

        env = arraystyle == :round      ? "bmatrix" :  # Round brackets
              arraystyle == :square     ? "Bmatrix" :  # Square brackets
              arraystyle == :curly      ? "pmatrix" :  # Curly braces (parentheses)
              arraystyle == :curlyarray ? "array"   :  # Curly array format
              "bmatrix"                               # Default to round brackets

        # Handle Rational matrices separately (factor out denominator)
        factor, int_mat = process_array(mat)           # Always process, even if no scaling needed
        factor_str      = f(factor)                    # Safe: factor is either "" or a rational number
        rows            = [join(f.(row), " & ") for row in eachrow(int_mat)]

        # LaTeX matrix formatting
        matrix_str = if arraystyle == :curlyarray
            "\\left(\\begin{array}{" * "r"^size(mat,2) * "}\n" *
            join(rows, " \\\\\n") * "\n\\end{array}\\right)"
        else
            "\\begin{$env}\n" * join(rows, " \\\\\n") * "\n\\end{$env}"
        end

        return isempty(factor_str) ? matrix_str : "$factor_str $matrix_str"
    end

    # --------------------------------------------------------------------------
    # Helper function to handle vectors by converting them to column matrices
    function latex_vector(vec::AbstractVector; arraystyle=:round)
        latex_matrix(reshape(vec, :, 1); arraystyle=arraystyle)
    end

    # --------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------
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
