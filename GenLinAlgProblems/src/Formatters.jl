@doc raw"""
bold\_formatter(x, i, j, formatted\_x)

Formats entries in **bold math font** for LaTeX outputs.

Args:
    x, i, j, formatted\_x : standard formatter arguments

Returns:
    A LaTeX string with the element wrapped in `\\boldsymbol{}`.
"""
function bold_formatter(x, i, j, formatted_x)
    return "\\boldsymbol{$formatted_x}"
end
@doc raw"""
italic\_formatter(x, i, j, formatted\_x)

Formats entries in **italic math font** for LaTeX outputs.

Args:
    x, i, j, formatted\_x : standard formatter arguments

Returns:
    A LaTeX string with the element wrapped in `\\mathit{}`.
"""
function italic_formatter(x, i, j, formatted_x)
    return "\\mathit{$formatted_x}"
end

@doc raw"""
color\_formatter(x, i, j, formatted\_x; color="red")

Applies a fixed **text color** to matrix entries in LaTeX.

Args:
    x, i, j, formatted\_x : standard formatter arguments
    color::String         : name of LaTeX color (default "red")

Returns:
    A LaTeX string wrapped in `\\textcolor{color}{}`.
"""
function color_formatter(x, i, j, formatted_x; color="red")
    return "\\textcolor{$color}{$formatted_x}"
end

@doc raw"""
conditional\_color\_formatter(x, i, j, formatted\_x)

Applies conditional colors to entries based on **sign** of values.

Positive → green, Negative → red, Zero → unchanged.

Args:
    x, i, j, formatted\_x : standard formatter arguments

Returns:
    Color-coded LaTeX string.
"""
function conditional_color_formatter(x, i, j, formatted_x)
    if x > 0
        return "\\textcolor{green}{$formatted_x}"
    elseif x < 0
        return "\\textcolor{red}{$formatted_x}"
    else
        return formatted_x
    end
end

@doc raw"""
highlight\_large\_values(x, i, j, formatted\_x; threshold=10)

Highlights matrix entries whose absolute value exceeds a threshold.

Args:
    x, i, j, formatted\_x : standard formatter arguments
    threshold::Real       : highlight cutoff (default 10)

Returns:
    Formatted element boxed with `\\boxed{}` when |x| > threshold.
"""
function highlight_large_values(x, i, j, formatted_x; threshold=10)
    if abs(x) > threshold
        return "\\boxed{$formatted_x}"
    else
        return formatted_x
    end
end

@doc raw"""
underline\_formatter(x, i, j, formatted\_x)

Draws an underline beneath the formatted entry in LaTeX.

Args:
    x, i, j, formatted\_x : standard formatter arguments

Returns:
    A LaTeX string wrapped in `\\underline{}`.
"""
function underline_formatter(x, i, j, formatted_x)
    return "\\underline{$formatted_x}"
end

@doc raw"""
overline\_formatter(x, i, j, formatted\_x)

Draws an overline above the formatted entry in LaTeX.

Args:
    x, i, j, formatted\_x : standard formatter arguments

Returns:
    A LaTeX string wrapped in `\\overline{}`.
"""
function overline_formatter(x, i, j, formatted_x)
    return "\\overline{$formatted_x}"
end

@doc raw"""
combine\_formatters(formatters, x, i, j, formatted\_x)

Sequentially applies a list of formatter functions to an entry.

Args:
    formatters::Vector{Function} : list of formatter functions
    x, i, j, formatted\_x         : standard formatter arguments

Returns:
    The resulting string after applying all given formatters in order.
"""
function combine_formatters(formatters, x, i, j, formatted_x)
    result = formatted_x
    for formatter in formatters
        result = formatter(x, i, j, result)
    end
    return result
end
# Example usage
#(x,i,j,fx) -> combine_formatters([bold_formatter, color_formatter],x,i,j,fx)
#
@doc raw"""
scientific\_formatter(x; digits=2)

Formats numeric values in **scientific notation** for display.

Args:
    x::Real       : numeric value
    digits::Int   : number of decimal digits (default 2)

Returns:
    A string like `"x e power"`, approximating scientific form.
"""
function scientific_formatter(x; digits=2)
    return string(x, "e", round(log10(abs(x)), digits=digits))
end
@doc raw"""
percentage\_formatter(x; digits=2)

Formats numeric values as **percentages**.

Args:
    x::Real       : numeric value
    digits::Int   : number of decimal places (default 2)

Returns:
    Rounded percentage value (no % sign added).
"""
function percentage_formatter(x; digits=2)
    return round(x * 100, digits=digits)
end
@doc raw"""
exponential\_formatter(x; digits=2)

Formats large or small numbers in compact exponential notation.

Args:
    x::Real       : numeric value
    digits::Int   : number of significant digits (default 2)

Returns:
    Rounded number, or string like `"m e p"` for powers of ten.
"""
function exponential_formatter(x; digits=2)
    if abs(x) >= 1e3 || abs(x) < 1e-3
        return string(round(x / 10^(round(log10(abs(x)))), digits=digits), "e", round(log10(abs(x))))
    else
        return round(x, digits=digits)
    end
end

@doc """
tril_formatter(x, i, j, formatted_x;
                           k::Int = 0,
                           color::String = "red",
                           c1::Int = 1,
                           c2::Int = typemax(Int),
                           r1::Int = 1,
                           r2::Int = typemax(Int))

Highlights entries that lie *on or below* a given diagonal (`k`), 
and optionally restricts the highlight to a specific **row** 
and/or **column** range.

Args:
    x, i, j, formatted_x : standard formatter arguments
    k::Int               : diagonal offset (0 = main diagonal)
    color::String        : LaTeX color for highlighting (default "red")
    c1::Int, c2::Int     : inclusive column range
    r1::Int, r2::Int     : inclusive row range

Behavior:
    - Colors entries where `(i >= j - k)` (below or on diagonal `k`)
      and within both the specified row and column ranges.
    - Entries outside the region remain unmodified.

Example:
    `tril_formatter(x, i, j, fx; k=1, color="blue", r1=2, r2=5, c1=3, c2=7)`
"""
function tril_formatter(x, i, j, formatted_x;
                                        k::Int = 0,
                                        color::String = "red",
                                        c1::Int = 1,
                                        c2::Int = typemax(Int),
                                        r1::Int = 1,
                                        r2::Int = typemax(Int))

    if (i >= j - k) && (c1 <= j <= c2) && (r1 <= i <= r2)
        return "\\textcolor{$color}{$formatted_x}"
    else
        return formatted_x
    end
end

@doc raw"""
block\_formatter(x, i, j, formatted\_x; r1=1, r2=1, c1=1, c2=1)

Highlights entries located within a specified rectangular **block**.

Args:
    x, i, j, formatted\_x : standard formatter arguments
    r1, r2::Int          : first and last rows of block
    c1, c2::Int          : first and last columns of block

Returns:
    Entry colored red if inside the block, unchanged otherwise.
"""
function block_formatter(x, i, j, formatted_x; r1=1, r2=1, c1=1, c2=1)
    # color entries in selected block in red
    if (r1 <= i <= r2) && (c1 <= j <= c2)
        return "\\textcolor{red}{$formatted_x}"
    else
        return formatted_x
    end
end

@doc raw"""
diagonal\_blocks\_formatter(x, i, j, formatted\_x;
                  blocks::Vector{Int},
                  colors::Vector{String} = ["red"])

Highlights entries belonging to diagonal blocks of a matrix.

A **negative block size** means "skip this block" — its entries are displayed
without special formatting.

Args:
    x, i, j, formatted\_x : standard formatter arguments
    blocks::Vector{Int}  : diagonal block sizes (negative → skip)
    colors::Vector{String}: highlight colors per block (defaults to all red)
"""
function diagonal_blocks_formatter(x, i, j, formatted_x;
                           blocks::Vector{Int},
                           colors::Vector{String} = ["red"])
    sizes   = abs.(blocks)
    limits  = cumsum(sizes)
    starts  = [1; limits[1:end-1] .+ 1]
    nblocks = length(blocks)

    # Determine which block this (i,j) belongs to, if any
    block_id = findfirst(k -> (starts[k] ≤ i ≤ limits[k] &&
                               starts[k] ≤ j ≤ limits[k]),
                         1:nblocks)

    # Not in any specified block → just return formatted_x
    isnothing(block_id) && return formatted_x

    # Negative block size ⇒ skip highlighting; show contents as-is
    blocks[block_id] < 0 && return formatted_x

    # Otherwise apply color highlighting
    color = colors[mod(block_id - 1, length(colors)) + 1]
    return "\\textcolor{$color}{$formatted_x}"
end
