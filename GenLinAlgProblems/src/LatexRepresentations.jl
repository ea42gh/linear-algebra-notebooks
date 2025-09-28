#using LinearAlgebra, Latexify

# ------------------------------------------------------------------------------
# ------------------------------------------------------- L string interpolation
# ------------------------------------------------------------------------------
@doc raw"""
interpolated_Lstring = L_interp(template::LaTeXString, substitutions::Dict{String, Any})

Example:
    expr = L\_interp(L"\mathbb{R}^{$(n)}", Dict("n" => 6))
"""
function L_interp(template::LaTeXString, substitutions::Dict)
    str = String(template)  # Convert LaTeXString to regular string
    for (key, value) in substitutions
        str = replace(str, "\$($key)" => string(value))  # Perform substitution
    end
    return LaTeXString(str)  # Convert back to LaTeXString
end
# ------------------------------------------------------------------------------
# ------------------------------------------ apply function to stack of matrices
# ------------------------------------------------------------------------------
function apply_function(f, matrices)
    return [ [ mat == :none ? :none : f.(mat) for mat in row ] for row in matrices ]
end

# -------------------------------------------------------------------------------
# -------------------------------------------------- rounding a stack of matrices
# -------------------------------------------------------------------------------
function round_value(x, digits::Int=0)
    v = round(x, digits=digits)

    # ✅ Convert to `Int` when `digits=0`
    return (digits == 0) ? Int(v) : v
end
# -------------------------------------------------------------------------------
function round_value(x::Complex, digits::Int=0)
    return Complex(
        round_value(real(x), digits),
        round_value(imag(x), digits)
    )
end
# ------------------------------------------------------------------------------
function round_matrices( matrices, digits=0 )
    apply_function( x->round_value(x,digits), matrices)
end
# ------------------------------------------------------------------------------
# -------------------------- factor out a denominator from an array of Rationals
# ------------------------------------------------------------------------------
# 🟢 Generalized function for factorizing denominators
"""Factor out denominator from vectors and matrices"""
function factor_out_denominator(A)
    1, A  # Default case: No factorization needed
end

# 🟢 Generalized function for factorizing denominators
function factor_out_denominator(A::AbstractArray)
    1, A  # Default case: No factorization needed
end

# ------------------------------------------------------------------------------
# 🟢 Handle Vectors of Rational{Int}
function factor_out_denominator(A::AbstractVector{Rational{Int}})
    d = reduce(lcm, denominator.(A))
    d, Int64.(d .* A)
end

# ------------------------------------------------------------------------------
# 🟢 Handle Matrices of Rational{Int}
function factor_out_denominator(A::AbstractMatrix{Rational{Int}})
    d = reduce(lcm, denominator.(A))
    d, Int64.(d .* A)
end

# ------------------------------------------------------------------------------
# 🟢 Handle Vectors of Complex{Rational{Int}}
function factor_out_denominator(A::AbstractVector{Complex{Rational{Int}}})
    denominators_real = denominator.(real.(A))
    denominators_imag = denominator.(imag.(A))

    d = reduce(lcm, vcat(denominators_real, denominators_imag), init=1)

    A_int = Complex{Int64}.(d .* real.(A), d .* imag.(A))

    return d, A_int  # Return LCM and the scaled vector
end

# ------------------------------------------------------------------------------
# 🟢 Handle Matrices of Complex{Rational{Int}}
function factor_out_denominator(A::AbstractMatrix{Complex{Rational{Int}}})
    denominators_real = denominator.(real.(A))
    denominators_imag = denominator.(imag.(A))

    d = reduce(lcm, vcat(denominators_real, denominators_imag), init=1)

    A_int = Complex{Int64}.(d .* real.(A), d .* imag.(A))

    return d, A_int  # Return LCM and the scaled matrix
end

# ------------------------------------------------------------------------------
# 🟢 Handle Transpose and Hermitian Transpose (Adjoint)
function factor_out_denominator(A::Transpose)
    d, A_factored = factor_out_denominator(parent(A))
    return d, transpose(A_factored)  # Preserve transposition
end

# ------------------------------------------------------------------------------
# 🟢 Handle BlockArrays by factoring the entire BlockMatrix correctly
function factor_out_denominator(A::BlockArray)
    # Convert BlockArray into a single contiguous Matrix representation
    full_matrix = copy(Matrix(A))  # Extract numerical content while preserving structure

    # Factorize the matrix without recursion
    d, A_factored = factor_out_denominator(full_matrix)

    # Reconstruct BlockArray with original block partitioning
    return d, BlockArray(A_factored, axes(A))
end

# ------------------------------------------------------------------------------
# 🟢 Handle Adjoints
function factor_out_denominator(A::Adjoint)
    d, A_factored = factor_out_denominator(parent(A))
    return d, A_factored'  # Preserve Hermitian transpose
end

# ------------------------------------------------------------------------------
# 🟢 Handle Reshaped Transposed Vectors
function factor_out_denominator(A::Base.ReshapedArray{T, 2, Adjoint{T, Vector{T}}, Tuple{}}) where T
    original_shape = size(A)  # Preserve the original shape
    d, A_factored = factor_out_denominator(parent(A))  # Factorize without reshaping

    reshaped_A_factored = reshape(A_factored, original_shape)
    return d, reshaped_A_factored
end

# ------------------------------------------------------------------------------
# --------------------------------------------- convert to latex, print np_array
# ------------------------------------------------------------------------------
function print_np_array_def(A; nm="A")
    function format_element(x)
        if x isa Rational
            return string(numerator(x)) * "//" * string(denominator(x))
        elseif x isa Complex
            real_part = real(x)
            imag_part = imag(x)
            if imag_part < 0
                return string(format_element(real_part)) * " - " * string(abs(imag_part)) * "j"
            else
                return string(format_element(real_part)) * " + " * string(imag_part) * "j"
            end
        elseif x isa Real
            return string(x)
        elseif x isa Integer
            return string(x)
        else
            error("Unsupported type for printing as NumPy array: $(typeof(x))")
        end
    end
    if ndims(A) == 1
        return nm*" = np.array([" * join(format_element.(A), ", ") * "])"
    else
        M, N = size(A)
        rows = ["[" * join(format_element.(A[i, :]), ", ") * "]" for i in 1:M]
        return nm*" = np.array([\n" * join(rows, ",\n") * "\n])"
    end
end
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Remove \cdot only for "numeric × symbol" patterns (keep all other dots)
fix_num_symbol_mul(s::AbstractString) = replace(String(s),
    # integers/decimals:   2 \cdot x  →  2 x,  -7\cdot\alpha → -7 \alpha
    r"(?:(?<=^)|(?<=\s))(-?(?:\d+(?:\.\d+)?))\s*\\cdot\s+(?=(\\?[A-Za-z]))" => s"\1 ",
    # fractions:           \frac{3}{2}\cdot \beta  →  \frac{3}{2} \beta
    r"(\\frac\{[^}]+\}\{[^}]+\})\s*\\cdot\s+(?=(\\?[A-Za-z]))"               => s"\1 ",
    # parenthesized numerics:  \left(12\right)\cdot x → \left(12\right) x
    r"(\\left\([^)]*\\right\))\s*\\cdot\s+(?=(\\?[A-Za-z]))"                 => s"\1 ",
)
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 🟢 Handle LaTeXString without extra `$` signs
function to_latex(x::LaTeXString; number_formatter=nothing)
    return strip(string(x), ['$', '\n'])
end

# ------------------------------------------------------------------------------
# 🟢 Handle Plain Strings and Characters
function to_latex(x::String; number_formatter=nothing)
    sanitized_str = replace(x, "_" => "\\_", "\$" => "\\\$")  # Escape underscores and dollar signs
    return "\\text{" * sanitized_str * "}"  # Wrap in \text{}
end

function to_latex(x::Char; number_formatter=nothing)
    return to_latex( string(x) )
end

# ------------------------------------------------------------------------------
# 🟢 Handle Rational Numbers (e.g., 3//4)
function to_latex(x::Rational{Int}; number_formatter=nothing)
    n, d = numerator(x), denominator(x)
    if d == 1
        return string(n)  # If denominator is 1, return integer
    else
        sign_str = n < 0 ? "-" : ""
        return sign_str * "\\frac{$(abs(n))}{$d}"
    end
end

# ------------------------------------------------------------------------------
# 🟢 Handle Complex Numbers: Distinguish between Int, Rational, and Float components
function to_latex(x::Complex{T}; number_formatter=nothing) where T
    #if number_formatter === nothing
    #    number_formatter = x -> x isa Integer || x isa Rational ? x : round(x, digits=8)
    #end
    x_real = real(x)
    x_imag = imag(x)

    if x_imag == 0
        return to_latex(x_real, number_formatter=number_formatter)  # Case: a + 0im → "a"
    elseif x_real == 0
        if x_imag == 1
            return "\\mathit{i}"   # Case: 0 + im → "i"
        elseif x_imag == -1
            return "-\\mathit{i}"  # Case: 0 - im → "-i"
        else
		return to_latex(x_imag, number_formatter=number_formatter) * "\\mathit{i}"  # Case: 0 + bi → "bi"
        end
    else
        xr         = to_latex(x_real; number_formatter=number_formatter)
        sgn        = x_imag < 0 ? "-" : "+"
	axi        = abs(x_imag)
	xi         = (axi == 1 ? "" : to_latex(axi; number_formatter=number_formatter)) * "\\mathit{i}"

        return xr * sgn * xi  # Case: a + bi
    end
end

# ------------------------------------------------------------------------------
# 🟢 Handle Numbers (Integer, Float)
function to_latex(x::Float64; number_formatter=nothing)
    # Apply number formatting if provided
    x = number_formatter !== nothing ? number_formatter(x) : x

    # Convert to string and check if it contains 'e' (scientific notation)
    str_x = string(x)

    if occursin('e', str_x)  # Detect scientific notation
        base, exponent = split(str_x, 'e')  # Split into coefficient and exponent
        exponent = replace(exponent, "+" => "")  # Remove the "+" sign for positive exponents
        return base * " e^{" * exponent * "}"  # Correct LaTeX format
    else
        return str_x  # Regular number, no exponent
    end
end

# ------------------------------------------------------------------------------
# 🟢 Handle Symbols (e.g., :x, :alpha)
# ------------------------------------------------------------------------------
function to_latex(x::Symbol; number_formatter=nothing)
    sympy_symbol = SymPy.Symbol(string(x))  # Convert Julia Symbol to SymPy Symbol
    return strip(latexify(sympy_symbol), ['$', '\n'])  # Convert to LaTeX and remove `$`
end
# ------------------------------------------------------------------------------
function to_latex(x::Sym{PyObject}; number_formatter=nothing)
    s = strip(latexify(x), ['$', '\n'])
    s = fix_num_symbol_mul(s)                                   # keep this
    s = replace(s, raw"\mathrm{I}" => raw"\mathit{i}",
                   r"(?<![A-Za-z\\])I(?![A-Za-z])" => raw"\mathit{i}")

    s = replace(s, r"(?<=^|\s)1\s*(\\mathit\{i\})" => (m -> m.captures[1]))
    return s
end
# ------------------------------------------------------------------------------
function to_latex(x::SymPy.SymbolicObject; number_formatter=nothing)
    s = strip(latexify(x), ['$', '\n'])
    s = fix_num_symbol_mul(s)
    s = replace(s, raw"\mathrm{I}" => raw"\mathit{i}",
                   r"(?<![A-Za-z\\])I(?![A-Za-z])" => raw"\mathit{i}")
    s = replace(s, r"(?<=^|\s)1\s*(\\mathit\{i\})" => (m -> m.captures[1]))
    return s
end
# ------------------------------------------------------------------------------
# 🟢 Catch-all for unsupported types
function to_latex(x; number_formatter=nothing)
    string(x)
end
# ------------------------------------------------------------------------------
# 🟢 Apply `to_latex` to any structured array-like object
function to_latex(A::AbstractArray; number_formatter=nothing)
    # Apply LaTeX conversion element-wise while preserving shape
    return map(x -> to_latex(x; number_formatter=number_formatter), A)
end

# ------------------------------------------------------------------------------
# 🟢 Handle Transpose and Adjoint
function to_latex(A::Transpose; number_formatter=nothing)
    # Process parent matrix and return transposed LaTeX version
    return to_latex(parent(A); number_formatter=number_formatter)'
end

function to_latex(A::Adjoint; number_formatter=nothing)
    # Process parent matrix and return adjoint (Hermitian transpose) LaTeX version
    return to_latex(parent(A); number_formatter=number_formatter)'
end

# ------------------------------------------------------------------------------
# 🟢 Handle BlockArrays
function to_latex(A::BlockArray; number_formatter=nothing)
    # Convert BlockArray into a structured LaTeX matrix format
    return to_latex(Matrix(A); number_formatter=number_formatter)
end

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 🟢 Apply `to_latex` to lists-of-lists (e.g., `[ [:none, A], [B, C], ...]` )
function to_latex(matrices::Vector; number_formatter=nothing)
    return [ [ mat == :none ? :none : to_latex(mat; number_formatter=number_formatter) for mat in row ] for row in matrices ]
end

# ==============================================================================
function latex(s::String) LaTeXStrings.LaTeXString(s) end

# ==============================================================================
# 🟢 Apply optional LaTeX styling (color handling)
function style_wrapper(content::Any, color_opt=nothing)
    str_content = string(content)  # Ensure it's a string
    str_content = replace(str_content, r"^\$|\$$" => "")  # Strip external `$` only

    if color_opt !== nothing
        return "\\textcolor{$color_opt}{$str_content}"
    else
        return str_content
    end
end

# ------------------------------------------------------------------------------
# 🟢 parse arraystyle argument
function parse_arraystyle(arraystyle, is_block_array=false)
    # Convert matrix environments to array environments if handling BlockArray
    valid_styles = [:bmatrix, :Bmatrix, :pmatrix, :vmatrix, :Vmatrix, :array, :barray, :Barray, :parray, :varray, :Varray]

    # 🚨 **Validate `arraystyle` input**
    if !(arraystyle in valid_styles)
        arraystyle=:array
    end

    if is_block_array
        arraystyle_map = Dict(
            :bmatrix  => :barray,
            :Bmatrix  => :Barray,
            :pmatrix  => :parray,
            :vmatrix  => :varray,
            :Vmatrix  => :Varray,
            :array    => :array  # No change needed
        )
        arraystyle = get(arraystyle_map, arraystyle, arraystyle)
    end

    # Map styles to LaTeX environments
    env_map = Dict(
        :bmatrix  => "bmatrix",
        :Bmatrix  => "Bmatrix",
        :pmatrix  => "pmatrix",
        :vmatrix  => "vmatrix",
        :Vmatrix  => "Vmatrix",
        :array    => "array",
        :barray   => "array",
        :Barray   => "array",
        :parray   => "array",
        :varray   => "array",
        :Varray   => "array"
    )
    matrix_env = get(env_map, arraystyle, "array")

    # Map array styles to enclosing brackets
    bracket_format = Dict(
        :barray   => ("\\left[", "\\right]"),
        :Barray   => ("\\left\\{", "\\right\\}"),
        :parray   => ("\\left(", "\\right)"),
        :varray   => ("\\left|", "\\right|"),
        :Varray   => ("\\left\\|", "\\right\\|"),
        :array    => ("", "")
    )
    left_bracket, right_bracket = get(bracket_format, arraystyle, ("", ""))

    return arraystyle, matrix_env, left_bracket, right_bracket
end

# ------------------------------------------------------------------------------
# 🟢 Construct column format strings for array environments
function construct_col_format(num_cols, col_dividers, alignment="r")
    # ✅ Ensure vertical dividers are placed correctly without modifying input list
    clean_dividers = filter(d -> d < num_cols, col_dividers)

    # ✅ Build column format string safely, avoiding `Bool` multiplication issue
    col_format = join(["$alignment" * (j in clean_dividers ? "|" : "") for j in 1:num_cols], "")

    return "{$col_format}"
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
    formatted_x = (number_formatter !== nothing) ? number_formatter(x) : x
    formatted   = to_latex(formatted_x)

    return style_wrapper(formatted, color)
end

# ------------------------------------------------------------------------------
# 🟢 Handle Strings and LaTeXStrings
function L_show_string(s; color=nothing)
    formatted = to_latex(s)
    return style_wrapper(formatted, color)
end

# ------------------------------------------------------------------------------
# 🟢 Construct the LaTeX representation of a matrix
function format_matrix_row(A, i, per_element_style, row_dividers)
    row = join(
        [begin
            x = A[i, j]
            formatted_x = to_latex(x)

            # Apply per-element styling
            per_element_style !== nothing ? per_element_style(x, i, j, formatted_x) : formatted_x
        end for j in 1:size(A,2)], " & ")

    return i in row_dividers && i < size(A, 1) ? row * " \\\\ \\hline" : row * " \\\\"
end

function construct_latex_matrix_body(A, arraystyle, is_block_array, per_element_style,
                                     factor_out, number_formatter,
                                     is_transposed, is_hermitian)

    # 🟢 Step 1: Parse the LaTeX environment based on arraystyle
    arraystyle, matrix_env, left_bracket, right_bracket = parse_arraystyle(arraystyle, is_block_array)

    # 🟢 Step 2: Process block matrix structure
    row_dividers, col_dividers = Int[], Int[]
    if is_block_array
        row_blocks, col_blocks = axes(A)
        row_dividers = cumsum(vcat(0, row_blocks.lasts[1:end-1]))
        col_dividers = cumsum(vcat(0, col_blocks.lasts[1:end-1]))
    end

    # 🟢 Step 3: Construct column format string
    col_format_str = matrix_env == "array" ? construct_col_format(size(A, 2), col_dividers) : ""


    # 🟢 Step 4: Apply number formatting if provided
    if number_formatter !== nothing
        A = map(x -> number_formatter(x), A)
    end

    # 🟢 Step 5: Factorization (numerical matrices only)
    contains_symbols = any(x -> x isa Symbol || x isa SymPy.Sym, A)
    factor, intA = contains_symbols ? (1, A) : process_array(A, factor_out)

    # 🟢 Step 6: Generate LaTeX matrix rows
    matrix_rows = [format_matrix_row(intA, i, per_element_style, row_dividers) for i in 1:size(A,1)]

    # 🟢 Step 7: Construct full LaTeX matrix
    matrix_body = left_bracket * "\\begin{$matrix_env}$col_format_str\n" *
                  join(matrix_rows, "\n") * "\n\\end{$matrix_env}" * right_bracket

    # 🟢 Step 8: Apply factorization if needed
    one_over_factor_str = factor == 1 ? "" : to_latex(1//factor)

    return isempty(one_over_factor_str) ? matrix_body : "$one_over_factor_str $matrix_body"
end

# ------------------------------------------------------------------------------
# 🟢 Handle Matrices (including symbolic matrices)
function L_show_matrix(A; arraystyle=:parray, is_block_array=false, color=nothing,
                       number_formatter=nothing, per_element_style=nothing,
                       factor_out=true)

    # 🟢 Detect if the input is transposed or Hermitian transposed
    is_transposed =    A isa Transpose{<:Any, <:AbstractMatrix} ||
                       A isa Transpose{<:Any, <:BlockArray}     ||
                       A isa Transpose{<:Any, <:AbstractVector}

    is_hermitian  =    A isa Adjoint{<:Any, <:AbstractMatrix} ||
                       A isa Adjoint{<:Any, <:BlockArray}     ||
                       A isa Adjoint{<:Any, <:AbstractVector}

    # 🟢 Convert vectors and adjoint vectors appropriately
    if A isa Transpose{<:Any, <:AbstractVector} ||
       A isa Adjoint{<:Any, <:AbstractVector} #A isa AbstractVector                     ||

       A = reshape(A, 1, :)  # Convert transposed/adjoint vector to (1×N) row matrix
    end

    # 🟢 Handle special matrix types
    if A isa SparseMatrixCSC
        A = Matrix(A)  # Convert sparse to dense
    elseif A isa Transpose{<:Any, <:BlockArray}   || A isa Adjoint{<:Any, <:BlockArray}
        is_block_array = true
    elseif A isa Diagonal
        A = Matrix(A)  # Convert to full matrix
    end

    # 🟢 Call helper function to construct LaTeX matrix representation
    latex_output = construct_latex_matrix_body(A, arraystyle, is_block_array, per_element_style,
                                               factor_out, number_formatter,
                                               is_transposed, is_hermitian)

    return style_wrapper(latex_output, color)
 end
# ------------------------------------------------------------------------------
# 🟢 Parsing function: Handles tuple inputs
"""
Extracts content values and formatting options from a NamedTuple.
Ensures symbols, numbers, and non-iterables are correctly handled.
"""
function parse_namedtuple_values(obj::NamedTuple)

    # ✅ Separate formatting keys from content values
    formatting_keys = [:arraystyle, :color, :separator, :number_formatter, :per_element_style, :factor_out ]
    formatting_options = Dict(k => v for (k, v) in pairs(obj) if k in formatting_keys)
    
    # ✅ Extract **actual** values, ensuring no erroneous splitting of strings
    content_values = Tuple(v for (k, v) in pairs(obj) if !(k in formatting_keys))

    # ✅ Ensure `content_values` remains a tuple and doesn't split into characters
    if length(content_values) == 1 && !(content_values[1] isa Tuple)
        content_values = (content_values[1],)  
    end
    
    return content_values, formatting_options
end

# ------------------------------------------------------------------------------
struct LinearCombination
    s
    X
    options::NamedTuple
end

raw"""
    lc(s, X; sign_policy=:plus, plus=L" + ", pos=L" + ", neg=L" - ",
             parens_coeff=true, omit_one=true, drop_zero=true)

Create a linear-combination group ∑ s[i]·X[:,i] that `l_show` knows how to render.
- `sign_policy=:plus`  → fixed separator `plus` between terms (like `set`)
- `sign_policy=:signed`→ use `pos` / `neg`, factoring a leading minus **only** for
                         single-term or explicitly parenthesized whole coefficients
- `parens_coeff`       → wrap multi-term coefficients in `\left( … \right)`
- `omit_one`, `drop_zero` → usual conveniences
"""
function lc(s, X; kwargs...)
    return LinearCombination(s, X, (; kwargs...))
end

# ------------------------------------------------------------------------------
struct Group
    entries::Tuple
    options::NamedTuple
end

"""
    set(args...; kwargs...) -> StyledSet

Creates a structured grouping of LaTeX components with optional formatting.
This prevents users from needing to interact directly with `StyledSet`.
"""
function set(entries...; kwargs...)
    return Group(entries, (; kwargs...))
end


"""
Handles LaTeX formatting for different object types (Tuples, NamedTuples, Matrices, Vectors, Numbers, Symbols, Strings).
Automatically applies formatting options (color, arraystyle, etc.).
"""
function L_show_core(obj; setstyle=:Barray, arraystyle=:parray, color=nothing, separator=", ", 
                     number_formatter=nothing, per_element_style=nothing, 
                     factor_out=true)

    # 🟢 Handle `Group` Struct
    if obj isa Group
        return L_show_set(obj;
            setstyle=setstyle,
            arraystyle=arraystyle,
            color=color,
            separator=separator,
            number_formatter=number_formatter,
            per_element_style=per_element_style,
        )
    end

    # 🟢 Handle LinearCombination group
    if obj isa LinearCombination
        return L_show_lc(obj; setstyle=setstyle, arraystyle=arraystyle, color=color,
                         number_formatter=number_formatter, per_element_style=per_element_style,
                         factor_out=factor_out)
    end

    # 🟢 Handle Empty Tuple (Format A with No Content)
    if obj isa Tuple && isempty(obj)
        _, _, left_delim, right_delim = parse_arraystyle(arraystyle)
        return style_wrapper("$(left_delim) $(right_delim)", color)
    end

    # 🟢 Handle NamedTuples (Format A with Local Formatting Overrides)
    if obj isa NamedTuple

        # ✅ Extract formatting options and primary content values
        formatting_keys = [:setstyle, :arraystyle, :color, :separator, :number_formatter, :per_element_style, :factor_out]
        formatting_options = Dict(k => v for (k, v) in pairs(obj) if k in formatting_keys)
        content_values = Tuple(v for (k, v) in pairs(obj) if !(k in formatting_keys))


        # ✅ Apply combined global & local formatting options
        combined_options = merge(Dict(
	    :setstyle => setstyle,
            :arraystyle => arraystyle, :color => color, :separator => separator,
            :number_formatter => number_formatter, :per_element_style => per_element_style,
            :factor_out => factor_out
        ), formatting_options)
        # ✅ Process NamedTuple Content (Each Entry Separately)
        formatted_entries = [L_show_core(entry; combined_options...) for entry in content_values]

        separator_str = replace(string(combined_options[:separator]), r"^\$|\$$" => "")
	return join(formatted_entries, separator_str)
    end

    # 🟢 Handle **Tuples as Format A** (Inline Concatenation)
    if obj isa Tuple
        formatted_entries = [L_show_core(entry;
            setstyle=setstyle,
            arraystyle=arraystyle,
            color=color,
            separator=separator,
            number_formatter=number_formatter,
            per_element_style=per_element_style,
            factor_out=factor_out,
        ) for entry in obj]          # ← forward all options
        separator_str = replace(string(separator), r"^\$|\$$" => "")
        return join(formatted_entries, separator_str)
    end

    # 🟢 Handle Strings and LaTeXStrings
    if obj isa AbstractString
        return L_show_string(obj; color=color)
    end

    # 🟢 Handle Characters
    if obj isa Char
        return L_show_string(string(obj); color=color)
    end
    
    # 🟢 Handle Transpose and Adjoint of Strings, Chars, and LaTeXStrings
    if obj isa Transpose{<:Any, <:String} || obj isa Adjoint{<:Any, <:String} ||
       obj isa Transpose{<:Any, <:Char}   || obj isa Adjoint{<:Any, <:Char} ||
       obj isa Transpose{<:Any, <:LaTeXString} || obj isa Adjoint{<:Any, <:LaTeXString}
       return L_show_string(parent(obj); color=color)
    end

    # 🟢 Handle Matrices, Vectors, and BlockArrays
    if obj isa AbstractVector || obj isa Transpose{<:Any, <:AbstractVector} || obj isa Adjoint{<:Any, <:AbstractVector} ||
       obj isa AbstractMatrix || obj isa Transpose{<:Any, <:AbstractMatrix} || obj isa Adjoint{<:Any, <:AbstractMatrix} ||
       obj isa BlockMatrix    || obj isa Transpose{<:Any, <:BlockMatrix}    || obj isa Adjoint{<:Any, <:BlockMatrix}    ||
       obj isa BlockArray     || obj isa Transpose{<:Any, <:BlockArray}     || obj isa Adjoint{<:Any, <:BlockArray}

        is_block_array = obj isa BlockArray  || obj isa Transpose{<:BlockArray}  || obj isa Adjoint{<:BlockArray}  ||
                         obj isa BlockMatrix || obj isa Transpose{<:BlockMatrix} || obj isa Adjoint{<:BlockMatrix}


        return L_show_matrix(obj; arraystyle=arraystyle, is_block_array=is_block_array,  
                             color=color, number_formatter=number_formatter,
                             per_element_style=per_element_style, factor_out=factor_out)
    end

    # 🟢 Handle Numbers, Symbols, and SymPy Expressions
    if obj isa Number || obj isa SymPy.Sym
        return L_show_number(obj; color=color, number_formatter=number_formatter)
    elseif obj isa Symbol
        return style_wrapper(to_latex(obj)*" ", color)
    end

    error("❌ Unsupported argument type: $(typeof(obj))")
end

# ------------------------------------------------------------------------------
# 🟢 Handle Groups
function L_show_set(obj_group; setstyle=:Barray, arraystyle=:parray, color=nothing, separator=", ", 
                      number_formatter=nothing, per_element_style=nothing)


    # ✅ Ensure `separator` is a LaTeXString but remove any unnecessary `$` wrappers
    clean_separator = separator isa LaTeXString ? separator : LaTeXString(separator)
    clean_separator = replace(string(clean_separator), "\$" => "")  # Remove spurious `$`

    # ✅ Get LaTeX delimiters based on arraystyle
    _, _, left_delim, right_delim = parse_arraystyle(setstyle)

    # Check if `obj_group` is actually a `Group`
    if !(obj_group isa Group)
        error("❌ `L_show_set` expected a `Group`, but got: $(typeof(obj_group))")
    end

    obj_latex = map(obj -> L_show_core(obj;
                                       arraystyle=arraystyle,
                                       color=color,
                                       separator=separator,
                                       number_formatter=number_formatter,
                                       per_element_style=per_element_style,
				       factor_out=true),
                    obj_group.entries)

    # ✅ Ensure proper LaTeX concatenation without extra `$`
    joined_latex = obj_latex[1]
    for i in 2:length(obj_latex)
        joined_latex *= " " * clean_separator * " " * obj_latex[i]
    end  

    # ✅ Wrap with delimiters (but no unnecessary `$`)
    formatted_group = LaTeXString("$(left_delim) " * joined_latex * " $(right_delim)")
    
    return style_wrapper(formatted_group, color)
end
# ------------------------------------------------------------------------------
function L_show_lc(lcobj::LinearCombination; setstyle=:parray, arraystyle=:parray, color=nothing,
                   number_formatter=nothing, per_element_style=nothing,
                   factor_out=true)

    # payload → locals (avoid scope/capture surprises)
    local s = lcobj.s
    local X = lcobj.X

    # merge options
    opts = merge(Dict(
        :sign_policy=>:plus, :plus=>L" + ", :pos=>L" + ", :neg=>L" - ",
        :parens_coeff=>true, :omit_one=>true, :drop_zero=>true),
        Dict(pairs(lcobj.options))
    )

    # render a single object to a math fragment (no $…$)
    inner = x -> L_show_core(x;
        arraystyle=arraystyle, color=color,
        number_formatter=number_formatter, per_element_style=per_element_style,
        factor_out=factor_out)

    # coefficient needs parens if it has an internal '+' or a non-leading '−'
    needs_parens = x -> begin
        t = inner(x)
        occursin(r"\+", t) || occursin(r"(?<!^)-", t)
    end

    # allow X to be a matrix (columns as terms) or a vector of terms
    n = X isa AbstractMatrix ? size(X, 2) : length(X)
    getvec(i) = X isa AbstractMatrix ? X[:, i] : X[i]

    # ---------------- sign_policy = :plus ----------------
    if opts[:sign_policy] === :plus
        terms = map(1:n) do i
            c = strip(inner(s[i]))
            if opts[:drop_zero] && c == "0"
                return nothing
            end
            c = (opts[:omit_one] && c == "1") ? "" :
                (opts[:parens_coeff] && needs_parens(s[i])) ? "\\left(" * c * "\\right)" : c
            v = inner(getvec(i))
            (a = LaTeXString(c), b = LaTeXString(v), separator = "")
        end |> x -> filter(!isnothing, x)

        if isempty(terms)
            return L_show_number(0; color=color, number_formatter=number_formatter)
        end

        g = Group((terms...,), (; setstyle=:array))
        return L_show_set(g;
            setstyle=:array, arraystyle=arraystyle, color=color,
            number_formatter=number_formatter, per_element_style=per_element_style,
            separator = opts[:plus])
    end

    # ---------------- sign_policy = :signed ----------------
    # extracts sign and whether a leading '-' can be factored cleanly
    split_sign = function(raw0::AbstractString)
        r = String(strip(raw0))
        if occursin(r"^-\s*\((.*)\)$", r)
            m = match(r"^-\s*\((.*)\)$", r)
            return (true, String(m.captures[1]), true)  # isneg, absraw, factorizable
        end
        if startswith(r, "-")
            absraw = String(strip(r[2:end]))
            single = !(occursin(r"\+", absraw) || occursin(r"(?<!^)-", absraw))
            return (true, absraw, single)
        end
        return (false, r, false)
    end

    pieces = Any[]
    for i in 1:n
        raw = String(strip(inner(s[i])))
        if opts[:drop_zero] && raw == "0"
            continue
        end
        isneg, absraw, factorizable = split_sign(raw)
        base = factorizable ? absraw : raw

        showtxt =
            (opts[:omit_one] && base == "1") ? "" :
            (opts[:parens_coeff] && needs_parens(factorizable ? absraw : raw)) ?
                "\\left(" * base * "\\right)" :
                base

        term = (a = LaTeXString(showtxt),
                b = LaTeXString(inner(getvec(i))),
                separator = "")

        if isempty(pieces)
            if isneg && factorizable
                push!(pieces, opts[:neg])
            end
            push!(pieces, term)
        else
            push!(pieces, (isneg && factorizable) ? opts[:neg] : opts[:pos])
            push!(pieces, term)
        end
    end

    if isempty(pieces)
        return L_show_number(0; color=color, number_formatter=number_formatter)
    end

    g = Group((pieces...,), (; setstyle=:array))
    return L_show_set(g;
        setstyle=:array, arraystyle=arraystyle, color=color,
        number_formatter=number_formatter, per_element_style=per_element_style,
        separator = L"")
end
# ------------------------------------------------------------------------------
# 🟢 Convert Objects to LaTeX Representation
"julia function to convert arguments to a LaTeX expression (see l_show)"
function L_show(objs...; setstyle=:parray, arraystyle=:parray, separator=", ", color=nothing, 
                number_formatter=nothing, per_element_style=nothing, factor_out=true, inline=true)

    formatted_objs = [
        obj isa Tuple ? 
            L_show_core(obj; arraystyle=arraystyle, separator=separator, color=color, 
                        number_formatter=number_formatter, per_element_style=per_element_style, 
                        factor_out=factor_out ) :
            L_show_core(obj; arraystyle=arraystyle, separator=separator, color=color, 
                        number_formatter=number_formatter, per_element_style=per_element_style, 
                        factor_out=factor_out)
        for obj in objs
    ]

    styled_content = join(formatted_objs, " ")  # Concatenate processed objects

    return inline ? "\$" * styled_content * "\$\n" : "\\[" * styled_content * "\\]\n"
end
# ------------------------------------------------------------------------------
# Allow SubString arguments everywhere
L_show(objs::SubString{String}; kwargs...)     = L_show(String(objs); kwargs...)
L_show_core(obj::SubString{String}; kwargs...) = L_show_core(String(obj); kwargs...)

# ------------------------------------------------------------------------------
# 🟢 Display arguments in python notebook
@doc raw"""
    l_show(objs...; arraystyle=:parray, color=nothing, number_formatter=nothing,
           inline=true, factor_out=true, per_element_style=nothing)

Convert numbers, vectors, matrices, and `BlockArray` structures into LaTeX-formatted strings.

# Arguments
- `objs...` : Numbers, matrices, vectors, `BlockArray`, `SymPy` expressions, etc.
- `arraystyle::Symbol = :parray` : LaTeX matrix format (`:bmatrix`, `:pmatrix`, `:array`, etc.).
- `color::Union{Nothing, String} = nothing` : Text color using `\textcolor{}` in LaTeX.
- `number_formatter::Union{Nothing, Function} = nothing` : Function to format numbers before LaTeX conversion.
- `inline::Bool = true` : If `true`, returns an inline LaTeX expression; otherwise, starts a new equation environment/
- `factor_out::Bool = true` : Factor out common denominators in rational entries.
- `per_element_style::Union{Nothing, Function} = nothing` : Function `(x, i, j, formatted) -> styled_string` for per-element formatting.

# Capabilities
- Converts numbers, symbols, and matrices to LaTeX.
- Handles rational, complex, symbolic (`SymPy`), and block-structured matrices.
- Supports transposed (`Transpose`), Hermitian (`Adjoint`), and `BlockArray`.
- Applies per-element styling (coloring, bold, etc.).
- Handles LaTeX environments (`bmatrix`, `array`, etc.).
- Optionally factors denominators in rational matrices.
- Supports `per_element_style` for individual cell formatting.
- Fully customizable with formatters and LaTeX options.

# Example Usage
```julia
using BlockArrays

A = BlockArray([1 2; 3 4], [1,1], [1,1])

println(L_show(A; per_element_style=bold_element))
This generates a LaTeX-formatted matrix with bold elements.

"""
function l_show(args...; kwargs...)
     LaTeXString(L_show(args...; kwargs... ))
end
# ------------------------------------------------------------------------------
# 🟢  Wrapper for Python's LaTeX rendering: use from julia in Python notebook
"julia function to convert arguments to a LaTeX expression directly displayed in a pythone notebook (see l_show)"
function py_show(args...; kwargs...)
    py_display   = pyimport("IPython.display").display
    py_latex     = pyimport("IPython.display").Latex
    latex_string = L_show(args...; kwargs...)
    py_display(py_latex(latex_string))
end
