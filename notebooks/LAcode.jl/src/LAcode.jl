module LAcode

export title, ge_layout, pt_frac

using PrettyTables,Printf,LinearAlgebra

struct T
    txt     ::String
    color   ::String
    justify ::String
    sz      ::Int
    height  ::Int
    f
end


T(txt;sz=20,color="darkred",justify="left",height=15) =
"<div style=\"float:center;width:100%;text-align:$(justify);\">
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz)pt;\">$(txt)</strong>
</div>"

T(txt1, txt2;sz1=20,sz2=20,color="darkred",justify="left",height=15) =
"<div style=\"float:center;width:100%;text-align:$(justify);\">
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz1)pt;\">$(txt1)</strong><br>
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz2)pt;\">$(txt2)</strong><br>
</div>"

#T(txt;sz=20,color="blue",justify="left",height=15) =
    #T(txt,color,justify,sz,height,()-> "<p style=\"color:$color;font-size:$(sz)pt;height:$(height)px;text-align:$justify;\">$txt</p>")

title( s :: T ) = display(HTML("<div>"* s.f()*"</div>"))
title( txt :: String; sz=20,color="blue",justify="left",height=15) = title( T(txt,sz=sz,color=color,justify=justify,height=height))
title( l :: Array{T} ) = display(HTML("<div>"* reduce( (x,y)->x.f()*y.f(), l )*"</div>"))

# usage examples
#title( T("Some text",sz=20) )       # single line output using  T()
#title( "="^300,sz=3)                # single line output
#title([ T("s",height=5,sz=25,color="magenta"),
#        T("x",sz=15,height=10)])    # multiline output

# original code
#function title( txt; sz=25,color="blue",justify="left", width=30)
#    t = """<br><div style="width:$(width)cm;color:$(color);text-align:$(justify);font-size:$(sz)px;height:$(sz+10)px">$(txt)</div>"""
#    display(HTML(t))
#end

# ===============================================================================================
function pt_f(value; d=2)
    @sprintf( "%.d", value)
end

function pt_frac(value)
    n,d=numerator(value),denominator(value)
    d == 1 ? "$n" : "$n &frasl; $d"
end
# -----------------------------------------------------------------------------------------------

function ge_layout( A, layers, pivots; to_str = LAcode.pt_frac, col_divs=nothing )
    Nrows,Ncols  = size(A)
    # table entry indices for the pivots; note j+m+1 to account for the inserted separator |
    # this tuple of index pairs will have corresponding entries colored magenta
    function colorize_pivots()
        p = Vector{Tuple{Int64,Int64}}()

        for (l,x) in enumerate(pivots)
            if isa(x[1], Tuple) || isa(x[1], Array)
                for i in x
                    push!(p, ((l-1)*Nrows+i[1], (i[2]+Nrows+1)))
                end
            else
                 push!(p, ((l-1)*Nrows+x[1], (x[2]+Nrows+1)))
            end
        end
        p
    end
    function insert_spacer( MA, col_divs, offset )
        if col_divs == nothing; return MA; end

        sp   = fill("<span class=verticalline></span>", size(MA,1),1)

        cols                            = [(offset+i) for i in col_divs]
        if offset > 0;             cols = [offset; cols];     end
        if cols[end] < size(MA,2); cols = [cols; size(MA,2)]; end

        M  = MA[:,1:cols[1]]
        for i in 2:length(cols)
            M = [M sp MA[:, cols[i-1]+1:cols[i]]]
        end
        M
    end

    p    = colorize_pivots() #p    = ( ((l-1)*Nrows+i, (j+Nrows+1))  for (l,(i,j)) in enumerate(pivots))

    hl = (
        # Pivot positions; alternate matrix backgrounds with iseven, isodd
        HTMLHighlighter((data,i,j)->iseven((i-1)÷Nrows+1)        && j>Nrows && (i,j) in p,
            HTMLDecoration(background = "#F0F0F0", color = "magenta" )),
        HTMLHighlighter((data,i,j)->isodd( (i-1)÷Nrows+1)        && j>Nrows && (i,j) in p,
            HTMLDecoration(background = "#FBFAFA", color = "magenta" )),

        HTMLHighlighter((data,i,j)->iseven((i-1)÷Nrows+1)        && j<=Nrows && (i,j) in p,
            HTMLDecoration(background = "#FDFAD4", color = "magenta" )),
        HTMLHighlighter((data,i,j)->i>Nrows && isodd( (i-1)÷Nrows+1) && j<=Nrows && (i,j) in p,
            HTMLDecoration(background = "#F6EFA1", color = "magenta" )),
        HTMLHighlighter((data,i,j)->i<=Nrows                 && j<=Nrows && (i,j) in p,
            HTMLDecoration(background = "#FFFFFF", color = "magenta" )),

        # non pivot positions
        HTMLHighlighter((data,i,j)->iseven((i-1)÷Nrows+1)        && j>Nrows,
            HTMLDecoration(background = "#F0F0F0", color = "blue" )),
        HTMLHighlighter((data,i,j)->isodd( (i-1)÷Nrows+1)        && j>Nrows,
            HTMLDecoration(background = "#FBFAFA", color = "blue" )),

        HTMLHighlighter((data,i,j)->iseven((i-1)÷Nrows+1)        && j<=Nrows,
            HTMLDecoration(background = "#FDFAD4", color = "blue" )),
        HTMLHighlighter((data,i,j)->i>Nrows && isodd( (i-1)÷Nrows+1) && j<=Nrows,
            HTMLDecoration(background = "#F6EFA1", color = "blue" )),
        HTMLHighlighter((data,i,j)->i<=Nrows                 && j<=Nrows,
            HTMLDecoration(background = "#FFFFFF", color = "blue" ))
    )

    tf  = HTMLTableFormat(css=""".verticalline { border-right: 1px solid black; height: 100%; }""" ) # dividing line css

    if length( layers ) > 0
        MA  = vcat( hcat( fill("", Nrows,Nrows), map(to_str, A)), # *  A
                    map( to_str, layers))                         # Ei Ai

        M   = insert_spacer( MA, col_divs, Nrows )
    else
        MA  = hcat( map(to_str, A))
        M   = insert_spacer( MA, col_divs, 0 )
    end

    pretty_table( M, noheader = true, highlighters=hl, tf=tf, backend = :html )
end
function ge_layout(A; pivots=[], to_str = pt_frac, col_divs=nothing )
    ge_layout( A, [], pivots, to_str = to_str, col_divs=col_divs )
end
# ===============================================================================================
"""Naive Gram-Schmidt"""
function w_gram_schmidt(B)
    A = convert.( Rational{Int64}, B)

    Q   = Array{eltype(A)}(undef, size(A))
    M,N = size(A)
    for j=1:N
        v_j = A[:,j]
        for k=1:j-1
            v_j = v_j - dot(Q[:,k], A[:,j])//dot(Q[:,k], Q[:,k]) .* Q[:,k]
        end
        Q[:,j] = v_j
    end
    Q
end
# -----------------------------------------------------------------------------------------------
function gram_schmidt(A)
    Q   = Array{eltype(A)}(undef, size(A))
    M,N = size(A)
    for j=1:N
        v_j = A[:,j]
        for k=1:j-1
            v_j = v_j - dot(Q[:,k], A[:,j]) .* Q[:,k]
        end
        Q[:,j] = v_j ./ norm(v_j)
    end
    Q
end
# -----------------------------------------------------------------------------------------------
"""Naive Modified Gram-Schmidt"""
function modified_gram_schmidt(A)
    Q   = Array{eltype(A)}(undef, size(A))
    M,N = size(A)

    V   = copy(A)
    for j=1:N
        Q[:,j] = V[:,j] ./ norm(V[:,j])
        for k=j+1:N
            V[:,k] = V[:,k] - dot(Q[:,j], V[:,k]) .* Q[:,j]
        end
    end
    Q
end
end # module
