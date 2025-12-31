import Base: show

struct HTMLOut
    html::String
end

function show(io::IO, ::MIME"text/html", x::HTMLOut)
    print(io, x.html)
end
#############################################################################################
function show_html(txt; sz=20, color="darkred", justify="left",
                   height=15, width=100, env="strong")
    HTMLOut(to_html(txt; sz=sz, color=color, justify=justify,
                    height=height, width=width, env=env))
end

function show_html(txt1, txt2; sz1=20, sz2=20, color="darkred",
                   justify="left", width=100, height=15, env="strong")
    HTMLOut(to_html(txt1, txt2; sz1=sz1, sz2=sz2, color=color,
                    justify=justify, height=height, width=width, env=env))
end

function pr(txt; sz=15, color="black", justify="left",
            height=15, width=100, env="p")
    show_html(txt; sz=sz, color=color, justify=justify,
              height=height, width=width, env=env)
end

#############################################################################################

function capture_output(f, args...)
    captured = IOCapture.capture() do
        f(args...)
    end
    return captured.output
end

function show_side_by_side_html(captured_outputs, titles=nothing)
    html = """
    <div style="display: flex; justify-content: space-between;">
    """

    if isnothing(titles)
        for output in captured_outputs
            html *= """
            <div style="flex: 1; align-content:flex-start; margin-right: 10px;">
            <pre>$output</pre>
            </div>
            """
        end
    else
        for (i, output) in enumerate(captured_outputs)
            title = titles[i]
            html *= """
            <div style="flex: 1; align-content:flex-start; margin-right: 10px;">
            <h4>$title</h4>
            <pre>$output</pre>
            </div>
            """
        end
    end

    html *= "</div>"
    return html
end
struct SideBySideHTML
    html::String
end


function show(io::IO, ::MIME"text/html", x::SideBySideHTML)
    print(io, x.html)
end
show_side_by_side(args...; kwargs...) =
    SideBySideHTML(show_side_by_side_html(args...; kwargs...))


# # Example Use of show_side_by_side
# function func1(x)
#     println("Output of func1 with argument $x")
# end
# 
# function func2(y)
#     println("Output of func2 with argument $y")
#     println("Another line from func2")
# end
# 
# function func3(z)
#     println("Output of func3 with argument $z")
#     println("Second line from func3")
#     println("Third line from func3")
# end
# 
# # Capture outputs
# outputs = [
#     capture_output(func1, 1),
#     capture_output(func2, 2),
#     capture_output(func3, 3)
# ]
# 
# # Display side by side with custom titles
# show_side_by_side(outputs, ["Function 1", "Function 2", "Function 3"])

