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
    if number_formatter !== nothing
        return replace( latexify(number_formatter(x)), "\$" => "")
    end

    n, d = numerator(x), denominator(x)
    if d == 1
        return string(n)
    else
        sign_str = n < 0 ? "-" : ""
        return sign_str * "\\frac{$(abs(n))}{$d}"
    end
end
# ------------------------------------------------------------------------------
function to_latex(c::Complex; number_formatter=nothing)
    real_part = to_latex(real(c); number_formatter=number_formatter)
    imag_val = imag(c)
    imag_val = number_formatter !== nothing ? number_formatter(imag_val) : imag_val

    if imag_val == 0
        return real_part  # Pure real number
    elseif real(c) == 0
        return imag_val == 1 ? "\\mathit{i}" :
               imag_val == -1 ? "-\\mathit{i}" :
               to_latex(imag_val; number_formatter=number_formatter) * "\\mathit{i}"
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
function to_latex(x::Symbol; number_formatter=nothing)
    return string(x)  # Simply return "x"
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

# ==============================================================================
# 🟢 Apply optional LaTeX styling (color handling)
function style_wrapper(content::Any, color_opt=nothing)
    str_content = string(content)  # 🔥 Ensure everything is converted to a String
    str_content = replace(str_content, r"^\$|\$$" => "")  # 🔥 Remove LaTeX `$...$` wrappers if they exist

    color_str = color_opt !== nothing ? "\\textcolor{$color_opt}{" : ""
    prefix    = color_str
    suffix    = (color_opt !== nothing ? "}" : "")

    return "$prefix$str_content$suffix"
end

# ------------------------------------------------------------------------------
# 🟢 Process Arrays: Factorization for Rational and Complex Rational Matrices
function process_array(A, factor_out=true)
    if !factor_out return 1, A end

    factor, intA = factor_out_denominator(A)  # Use helper function
    return factor, intA
end

# ------------------------------------------------------------------------------
# 🟢 Handle Numbers and Symbols using `to_latex`
function L_show_number(x; color=nothing, number_formatter=nothing)
    formatted_x = if number_formatter !== nothing number_formatter(x) else x end
    formatted   = if formatted_x isa String formatted_x else to_latex(formatted_x) end
    return style_wrapper(formatted, color)  # No `$...$` wrapping!
end

# ------------------------------------------------------------------------------
# 🟢 Handle Strings and LaTeXStrings
function L_show_string(s; color=nothing)
    if s isa LaTeXString
        return style_wrapper(strip(string(s), ['$', '\n']), color)
    else
        return style_wrapper("\\text{" * replace(s, "_" => "\\_") * "}", color)
    end
end
# ------------------------------------------------------------------------------
# 🟢 Handle Matrices (including symbolic matrices)
function L_show_matrix(A; arraystyle=:array, color=nothing, number_formatter=nothing,
                          per_element_style=nothing, factor_out=true, bold_matrix=false)

    # Convert vectors to column matrices for uniform handling
    A = A isa AbstractVector ? reshape(A, :, 1) : A

    # Handle special matrix types
    if A isa SparseMatrixCSC
        A = Matrix(A)  # Convert sparse to dense
    elseif A isa Adjoint || A isa Symmetric || A isa Hermitian
        A = parent(A)  # Extract parent matrix
    elseif A isa Diagonal
        A = Matrix(A)  # Convert to full matrix
    end

    # Check for symbolic entries
    contains_symbols = any(x -> x isa Symbol || x isa SymPy.Sym, A)

    env = Dict(
        :bmatrix  => "bmatrix",
        :Bmatrix  => "Bmatrix",
        :pmatrix  => "pmatrix",
        :vmatrix  => "vmatrix",
        :Vmatrix  => "Vmatrix",
        :array    => "array"
    )

    matrix_env = get(env, arraystyle, "array")

    # Factorization is only applicable for numerical matrices
    factor, intA = contains_symbols ? (1, A) : process_array(A, factor_out)

    # Apply `number_formatter` to `1//factor` BEFORE converting to LaTeX
    if factor == 1
        factor_str = ""
    else
        numeric_factor = 1//factor
        formatted_factor = number_formatter !== nothing ? number_formatter(numeric_factor) : numeric_factor
        factor_str = to_latex(formatted_factor)
        if bold_matrix factor_str = "\\mathbf{" * factor_str * "}" end
    end

    # Apply styling to matrix elements
    rows = [join(
        [begin
            x = intA[i, j]
            formatted_x = number_formatter !== nothing ? number_formatter(x) : to_latex(x)

            # Step 1: Apply `per_element_style` FIRST (e.g., colors, special formatting)
            formatted_x = per_element_style !== nothing ? per_element_style(x, i, j, formatted_x) : formatted_x

            # Step 2: Apply `\textbf{}` LAST to keep everything bold
            bold_matrix ? "\\textbf{" * formatted_x * "}" : formatted_x
        end for j in 1:size(A,2)], " & ") for i in 1:size(A,1)]

    # Ensure empty matrices don't cause failures by checking `join(rows, " \\\\\n")`
    matrix_body = if arraystyle == :array
        "\\left(\\begin{array}{" * "r"^size(A,2) * "}\n" *
        (isempty(rows) ? "" : join(rows, " \\\\\n")) * "\n\\end{array}\\right)"
    else
        "\\begin{$matrix_env}\n" * (isempty(rows) ? "" : join(rows, " \\\\\n")) * "\n\\end{$matrix_env}"
    end

    return isempty(factor_str) ? style_wrapper(matrix_body, color) : style_wrapper("$factor_str $matrix_body", color)
end
# ------------------------------------------------------------------------------
# 🟢 Core function: Handles arguments but doesn't wrap in equation delimiters
function L_show_core(obj; arraystyle=:array, color=nothing, number_formatter=nothing, 
                        per_element_style=nothing, factor_out=true, bold_matrix=false)

    # Handle NamedTuples with multiple options
    if obj isa NamedTuple
        # Extract the primary value (assume first non-keyword argument is the object)
        value = nothing
        options = Dict{Symbol, Any}()

        for (key, val) in pairs(obj)
            if value === nothing && !(key in [:arraystyle, :color, :number_formatter, :per_element_style, :factor_out, :bold_matrix])
                value = val  # Assume first non-keyword argument is the main object
            else
                options[key] = val  # Store additional options
            end
        end

        if value === nothing
            error("NamedTuple must contain at least one primary value (e.g., text, matrix, number).")
        end

        # Recursively call `L_show_core` with extracted options
        return L_show_core(value; arraystyle=get(options, :arraystyle, arraystyle), 
                                      color=get(options, :color, color), 
                                      number_formatter=get(options, :number_formatter, number_formatter), 
                                      per_element_style=get(options, :per_element_style, per_element_style), 
                                      factor_out=get(options, :factor_out, factor_out), 
                                      bold_matrix=get(options, :bold_matrix, bold_matrix))
    end

    if obj isa AbstractMatrix || obj isa AbstractVector                             # 🔥 Matrices & Vectors
        return L_show_matrix(obj; arraystyle=arraystyle, color=color, 
                                  number_formatter=number_formatter, 
                                  per_element_style=per_element_style, 
                                  factor_out=factor_out, bold_matrix=bold_matrix)

    elseif obj isa String || obj isa LaTeXString                                    # 🔥 Handles Strings
        return L_show_string(obj; color=color)

    elseif obj isa Number || obj isa Symbol || obj isa SymPy.Sym                    # 🔥 Handles Numbers & Symbols
        return L_show_number(obj; color=color, number_formatter=number_formatter)

    else
        error("Unsupported argument type: $(typeof(obj))")
    end
end

# ------------------------------------------------------------------------------
# 🟢 Convert arguments to valid LaTeX 
function L_show(objs...; arraystyle=:array, color=nothing, number_formatter=nothing, 
                 inline=true, factor_out=true, bold_matrix=false, per_element_style=nothing)

    # Step 1: Process each argument separately
    formatted_objs = map(obj -> L_show_core(obj; 
                                arraystyle=arraystyle, color=color, 
                                number_formatter=number_formatter, 
                                factor_out=factor_out, bold_matrix=bold_matrix, 
                                per_element_style=per_element_style), objs)

    # Step 2: Combine processed arguments into a single LaTeX string
    styled_content = join(formatted_objs, " ")

    # Step 3: Apply inline or block wrapping
    return inline ? "\$" * styled_content * "\$\n" : "\\[" * styled_content * "\\]\n"
end
# ------------------------------------------------------------------------------
# 🟢 Display arguments in python notebook
"convert arguments to a LaTeX expression. directly display in notebook"
function l_show(args...; kwargs...)
     LaTeXString(L_show(args...; kwargs... ))
end
# ------------------------------------------------------------------------------
# 🟢  Wrapper for Python's LaTeX rendering: use from julia in Python notebook
function py_show(args...; kwargs...)
    py_display   = pyimport("IPython.display").display
    py_latex     = pyimport("IPython.display").Latex
    latex_string = L_show(args...; kwargs...)
    py_display(py_latex(latex_string))
end
