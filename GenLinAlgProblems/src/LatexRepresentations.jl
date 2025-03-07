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
    return replace(latexify(x), "\$" => "")  # Convert to LaTeX
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
    str_content = string(content)  #  Ensure everything is converted to a String
    str_content = replace(str_content, r"^\$|\$$" => "")  #  Remove LaTeX `$...$` wrappers if they exist

    color_str = color_opt !== nothing ? "\\textcolor{$color_opt}{" : ""
    prefix    = color_str
    suffix    = (color_opt !== nothing ? "}" : "")

    return "$prefix$str_content$suffix"
end

# ------------------------------------------------------------------------------
# 🟢 parse arraystyle argument
function parse_arraystyle(arraystyle, is_block_array=false)
    # Convert matrix environments to array environments if handling BlockArray
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
function construct_col_format(num_cols, col_dividers)
    # Ensure the last column does NOT get a vertical divider
    if !isempty(col_dividers) && col_dividers[end] == num_cols
        pop!(col_dividers)  # Remove last column divider
    end
    col_format_parts = String[]
    for j in 1:num_cols
        push!(col_format_parts, "r")
        if j in col_dividers
            push!(col_format_parts, "|")  # Add vertical divider at block boundaries
        end
    end
    return "{" * join(col_format_parts, "") * "}"
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
# 🟢 Construct the LaTeX representation of a matrix
function construct_latex_matrix_body(A, arraystyle, is_block_array, per_element_style,
                                     factor_out, bold_matrix, number_formatter,
                                     is_transposed, is_hermitian)

    # 🟢 Step 1: Parse the LaTeX environment based on arraystyle
    arraystyle, matrix_env, left_bracket, right_bracket = parse_arraystyle(arraystyle, is_block_array)

    # 🟢 Step 2: Adjust for transposition (Swap row & column dividers)
    row_dividers, col_dividers = Int[], Int[]
    if is_block_array
        row_blocks, col_blocks = axes(A)
        row_dividers = cumsum(vcat(0, row_blocks.lasts[1:end-1]))
        col_dividers = cumsum(vcat(0, col_blocks.lasts[1:end-1]))
    end

    # 🟢 Step 3: Ensure the last column does NOT get an extra vertical divider

    col_format_str = arraystyle in [:array, :barray, :Barray, :parray, :varray, :Varray] ?
                 construct_col_format(is_transposed || is_hermitian ? size(A,1) : size(A,2), col_dividers) : ""

    # 🟢 Step 4: Apply number formatting if provided
    if number_formatter !== nothing
        A = map(x -> number_formatter(x), A)
    end

    # 🟢 Step 5: Factorization (numerical matrices only)
    contains_symbols = any(x -> x isa Symbol || x isa SymPy.Sym, A)
    factor, intA     = contains_symbols ? (1, A) : process_array(A, factor_out)

    # 🟢 Step 6: Generate LaTeX representation of matrix body
    matrix_rows = []
    for i in 1:size(A, 1)
        row = join(
            [begin
		x = intA[i,j]
		formatted_x = to_latex( x )

                # Apply per-element style if provided
                formatted_x = per_element_style !== nothing ? per_element_style(x, i, j, formatted_x) : formatted_x


                # Apply bold formatting last
                bold_matrix ? "\\mathbf{$formatted_x}" : formatted_x
            end for j in 1:size(A,2)], " & ")

        if i in row_dividers && i < size(A, 1)
            push!(matrix_rows, row * " \\\\ \\hline")
        else
            push!(matrix_rows, row * " \\\\")
        end
    end

    # 🟢 Step 7: Construct full LaTeX matrix
    matrix_body = left_bracket * "\\begin{$matrix_env}$col_format_str\n" *
                  join(matrix_rows, "\n") * "\n\\end{$matrix_env}" * right_bracket

    # 🟢 Step 8: Factor formatting
    one_over_factor_str = factor == 1 ? "" : to_latex(1//factor)
    factor_str          = bold_matrix ? "\\mathbf{$one_over_factor_str}" : one_over_factor_str

    return isempty(factor_str) ? matrix_body : "$factor_str $matrix_body"
end

# ------------------------------------------------------------------------------
# 🟢 Handle Matrices (including symbolic matrices)
function L_show_matrix(A; arraystyle=:parray, is_block_array=false, color=nothing,
                       number_formatter=nothing, per_element_style=nothing,
                       factor_out=true, bold_matrix=false)

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
                                               factor_out, bold_matrix, number_formatter,
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
    #println("🔎 Parsing NamedTuple: ", obj)  # 🔴 DEBUGGING PRINT

    # ✅ Separate formatting keys from content values
    formatting_keys = [:arraystyle, :color, :separator, :number_formatter, :per_element_style, :factor_out, :bold_matrix]
    formatting_options = Dict(k => v for (k, v) in pairs(obj) if k in formatting_keys)
    
    # ✅ Extract **actual** values, ensuring no erroneous splitting of strings
    content_values = Tuple(v for (k, v) in pairs(obj) if !(k in formatting_keys))

    #println("🎨 pairs(obj): ", pairs(obj))  # 🔴 DEBUGGING PRINT
    #println("🎨 Formatting Options Extracted: ", formatting_options)  # 🔴 DEBUGGING PRINT
    #println("📦 Raw Content Values Extracted: ", content_values)  # 🔴 DEBUGGING PRINT

    # 🛑 **Fix iterate(::Symbol) error**  
    # ✅ Ensure `content_values` remains a tuple and doesn't split into characters
    if length(content_values) == 1 && !(content_values[1] isa Tuple)
        content_values = (content_values[1],)  
    end
    
    #println("📦 Final Content Values (Tuple): ", content_values)  # 🔴 DEBUGGING PRINT

    return content_values, formatting_options
end

# ------------------------------------------------------------------------------
struct Group
    entries::Tuple
    options::NamedTuple
end

"""
    group(args...; kwargs...) -> StyledSet

Creates a structured grouping of LaTeX components with optional formatting.
This prevents users from needing to interact directly with `StyledSet`.
"""
function group(entries...; kwargs...)
    return Group(entries, (; kwargs...))
end


"""
Handles LaTeX formatting for different object types (Tuples, NamedTuples, Matrices, Vectors, Numbers, Symbols, Strings).
Automatically applies formatting options (color, arraystyle, etc.).
"""
function L_show_core(obj; groupstyle=:Barray, arraystyle=:parray, color=nothing, separator=", ", 
                     number_formatter=nothing, per_element_style=nothing, 
                     factor_out=true, bold_matrix=false)

    # 🟢 Handle `Group` Struct
    if obj isa Group
        #println("🔎 Processing Group: ", obj)
        return L_show_group(obj; groupstyle=groupstyle, obj.options...)  # ✅ Process group with its options
    end

    # 🟢 Handle Empty Tuple (Format A with No Content)
    if obj isa Tuple && isempty(obj)
        #println("🔎 Detected empty tuple")  
        _, _, left_delim, right_delim = parse_arraystyle(arraystyle)
        return style_wrapper("$(left_delim) $(right_delim)", color)
    end

    # 🟢 Handle NamedTuples (Format A with Local Formatting Overrides)
    if obj isa NamedTuple
        #println("🔎 Detected NamedTuple: ", obj)

        # ✅ Extract formatting options and primary content values
        formatting_keys = [:groupstyle, :arraystyle, :color, :separator, :number_formatter, :per_element_style, :factor_out, :bold_matrix]
        formatting_options = Dict(k => v for (k, v) in pairs(obj) if k in formatting_keys)
        content_values = Tuple(v for (k, v) in pairs(obj) if !(k in formatting_keys))

        #println("🎨 Formatting Options Extracted: ", formatting_options)
        #println("📦 Content Values Extracted: ", content_values)

        # ✅ Apply combined global & local formatting options
        combined_options = merge(Dict(
	    :groupstyle => groupstyle,
            :arraystyle => arraystyle, :color => color, :separator => separator,
            :number_formatter => number_formatter, :per_element_style => per_element_style,
            :factor_out => factor_out, :bold_matrix => bold_matrix
        ), formatting_options)

        # ✅ Process NamedTuple Content (Each Entry Separately)
        formatted_entries = [L_show_core(entry; combined_options...) for entry in content_values]
        return join(formatted_entries, "")  # ✅ Inline Concatenation (NO SEPARATORS)
    end

    # 🟢 Handle **Tuples as Format A** (Inline Concatenation)
    if obj isa Tuple
        #println("🔎 Detected Tuple (Format A): ", obj)
        formatted_entries = [L_show_core(entry; groupstyle=groupstyle, arraystyle=arraystyle, color=color, separator=separator) for entry in obj]
        return join(formatted_entries, "")  # ✅ Tuples are concatenated inline
    end

    # 🟢 Handle Strings and LaTeXStrings
    if obj isa String || obj isa LaTeXString
        #println("🔎 Detected String: ", obj)  
        return L_show_string(obj; color=color)
    end

    # 🟢 Handle Matrices, Vectors, and BlockArrays
    is_block_array = obj isa BlockArray  || obj isa Transpose{<:BlockArray}  || obj isa Adjoint{<:BlockArray}  ||
                     obj isa BlockMatrix || obj isa Transpose{<:BlockMatrix} || obj isa Adjoint{<:BlockMatrix}

    if obj isa AbstractVector || obj isa Transpose{<:Any, <:AbstractVector} || obj isa Adjoint{<:Any, <:AbstractVector} ||
       obj isa AbstractMatrix || obj isa Transpose{<:Any, <:AbstractMatrix} || obj isa Adjoint{<:Any, <:AbstractMatrix} ||
       obj isa BlockMatrix    || obj isa Transpose{<:Any, <:BlockMatrix}    || obj isa Adjoint{<:Any, <:BlockMatrix}    ||
       obj isa BlockArray     || obj isa Transpose{<:Any, <:BlockArray}     || obj isa Adjoint{<:Any, <:BlockArray}


        #println("🔎 Detected Matrix/Vector: ", obj)  
        return L_show_matrix(obj; arraystyle=arraystyle, is_block_array=is_block_array,  
                             color=color, number_formatter=number_formatter,
                             per_element_style=per_element_style, factor_out=factor_out, bold_matrix=bold_matrix)
    end

    # 🟢 Handle Numbers, Symbols, and SymPy Expressions
    if obj isa Number || obj isa SymPy.Sym
        #println("🔎 Detected Number/Symbol: ", obj)  
        return L_show_number(obj; color=color, number_formatter=number_formatter)
    elseif obj isa Symbol
        #println("🔎 Detected Symbol: ", obj)  
        return style_wrapper(to_latex(obj)*" ", color)
    end

    error("❌ Unsupported argument type: $(typeof(obj))")
end

# ------------------------------------------------------------------------------
# 🟢 Handle Groups
function L_show_group(obj_group; groupstyle=:Barray, arraystyle=:parray, color=nothing, separator=", ", 
                      number_formatter=nothing, per_element_style=nothing)

    #println("🔎 Processing group: ", obj_group)  # Debugging print
    #println("🔎 Type of obj_group: ", typeof(obj_group))  # 🔴 Track the type

    # ✅ Ensure `separator` is a LaTeXString but remove any unnecessary `$` wrappers
    clean_separator = separator isa LaTeXString ? separator : LaTeXString(separator)
    clean_separator = replace(string(clean_separator), "\$" => "")  # Remove spurious `$`

    # ✅ Get LaTeX delimiters based on arraystyle
    _, _, left_delim, right_delim = parse_arraystyle(groupstyle)

    # 🚨 **Check if `obj_group` is actually a `Group`** 🚨
    if !(obj_group isa Group)
        error("❌ `L_show_group` expected a `Group`, but got: $(typeof(obj_group))")
    end

    # ✅ Process each group entry
    obj_latex = map(obj -> begin
        if obj isa Tuple
            #println("⚠️ Detected tuple inside a group: ", obj)  # Debugging print
            return L_show_core(obj...)  # Spread tuple contents to apply Format A overrides
        else
            return L_show_core(obj; arraystyle=arraystyle, 
                               number_formatter=number_formatter, 
                               per_element_style=per_element_style)
        end
    end, obj_group.entries)

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
# 🟢 Convert Objects to LaTeX Representation
"julia function to convert arguments to a LaTeX expression (see l_show)"
function L_show(objs...; groupstyle=:parray, arraystyle=:parray, separator=", ", color=nothing, 
                number_formatter=nothing, per_element_style=nothing, factor_out=true, bold_matrix=false, inline=true)

    formatted_objs = [
        obj isa Tuple ? 
            L_show_core(obj; arraystyle=arraystyle, separator=separator, color=color, 
                        number_formatter=number_formatter, per_element_style=per_element_style, 
                        factor_out=factor_out, bold_matrix=bold_matrix) :
            L_show_core(obj; arraystyle=arraystyle, separator=separator, color=color, 
                        number_formatter=number_formatter, per_element_style=per_element_style, 
                        factor_out=factor_out, bold_matrix=bold_matrix)
        for obj in objs
    ]

    styled_content = join(formatted_objs, " ")  # Concatenate processed objects

    return inline ? "\$" * styled_content * "\$\n" : "\\[" * styled_content * "\\]\n"
end

# ------------------------------------------------------------------------------
# 🟢 Display arguments in python notebook
"""
    l_show(objs...; arraystyle=:parray, color=nothing, number_formatter=nothing,
           inline=true, factor_out=true, bold_matrix=false, per_element_style=nothing)

Convert numbers, vectors, matrices, and `BlockArray` structures into LaTeX-formatted strings.

# Arguments
- `objs...` : Numbers, matrices, vectors, `BlockArray`, `SymPy` expressions, etc.
- `arraystyle::Symbol = :parray` : LaTeX matrix format (`:bmatrix`, `:pmatrix`, `:array`, etc.).
- `color::Union{Nothing, String} = nothing` : Text color using `\textcolor{}` in LaTeX.
- `number_formatter::Union{Nothing, Function} = nothing` : Function to format numbers before LaTeX conversion.
- `inline::Bool = true` : If `true`, returns an inline LaTeX expression; otherwise, starts a new equation environment/
- `factor_out::Bool = true` : Factor out common denominators in rational entries.
- `bold_matrix::Bool = false` : Applies `\\mathbf{}` to all matrix elements.
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

println(L_show(A; bold_matrix=true))
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
