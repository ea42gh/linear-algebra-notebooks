function bold_formatter(x, i, j, formatted_x)
    return "\\boldsymbol{$formatted_x}"
end
function italic_formatter(x, i, j, formatted_x)
    return "\\mathit{$formatted_x}"
end
function color_formatter(x, i, j, formatted_x; color="red")
    return "\\textcolor{$color}{$formatted_x}"
end
function conditional_color_formatter(x, i, j, formatted_x)
    if x > 0
        return "\\textcolor{green}{$formatted_x}"
    elseif x < 0
        return "\\textcolor{red}{$formatted_x}"
    else
        return formatted_x
    end
end
function highlight_large_values(x, i, j, formatted_x; threshold=10)
    if abs(x) > threshold
        return "\\boxed{$formatted_x}"
    else
        return formatted_x
    end
end
function underline_formatter(x, i, j, formatted_x)
    return "\\underline{$formatted_x}"
end
function overline_formatter(x, i, j, formatted_x)
    return "\\overline{$formatted_x}"
end


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
#
function scientific_formatter(x; digits=2)
    return string(x, "e", round(log10(abs(x)), digits=digits))
end
function percentage_formatter(x; digits=2)
    return round(x * 100, digits=digits)
end
function exponential_formatter(x; digits=2)
    if abs(x) >= 1e3 || abs(x) < 1e-3
        return string(round(x / 10^(round(log10(abs(x)))), digits=digits), "e", round(log10(abs(x))))
    else
        return round(x, digits=digits)
    end
end


function tril_formatter(x, i, j, formatted_x;
                        k::Int = 0,               # offset from diagonal
                        color::String = "red",
                        c1::Int = 1,              # first column
                        c2::Int = typemax(Int))   # last column
    if (i >= j - k) && (c1 <= j <= c2)
        return "\\textcolor{$color}{$formatted_x}"
    else
        return formatted_x
    end
end

function block_formatter(x, i, j, formatted_x; r1=1, r2=1, c1=1, c2=1)
    # color entries in selected block in red
    if (r1 <= i <= r2) && (c1 <= j <= c2)
        return "\\textcolor{red}{$formatted_x}"
    else
        return formatted_x
    end
end
