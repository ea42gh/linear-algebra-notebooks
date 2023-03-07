
function to_html(txt;sz=20,color="darkred",justify="left",height=15)
"<div style=\"float:center;width:100%;text-align:$(justify);\">
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz)pt;\">$(txt)</strong>
</div>"
end

function to_html(txt1, txt2;sz1=20,sz2=20,color="darkred",justify="left",height=15)
"<div style=\"float:center;width:100%;text-align:$(justify);\">
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz1)pt;\">$(txt1)</strong><br>
<strong style=\"height:$(height)px;color:$(color);font-size:$(sz2)pt;\">$(txt2)</strong><br>
</div>"
end

function show_html(txt;sz=20,color="darkred",justify="left",height=15)
    display( HTML( to_html( txt; sz=sz, color=color, justify=justify, height=height ) ))
end
function show_html(txt1, txt2;sz1=20,sz2=20,color="darkred",justify="left",height=15)
    txt = to_html(txt1, txt2;sz1=sz1,sz2=sz2,color=color,justify=justify,height=height)
    display( HTML(txt))
end

