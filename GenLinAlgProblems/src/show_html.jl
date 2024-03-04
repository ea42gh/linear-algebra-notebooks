
function to_html(txt;sz=20,color="darkred",justify="left",height=15,width=100, env="strong")
  "<div style=\"float:center;width:$(width)%;text-align:$(justify);\">
  <$(env) style=\"height:$(height)px;color:$(color);font-size:$(sz)pt;\">$(txt)</$(env)>
</div>"
end

function to_html(txt1, txt2;sz1=20,sz2=20,color="darkred",justify="left",height=15,width=100,env="strong")
  "<div style=\"float:center;width:$(width)%;text-align:$(justify);\">
   <$(env) style=\"height:$(height)px;color:$(color);font-size:$(sz1)pt;\">$(txt1)</$(env)><br>
   <$(env) style=\"height:$(height)px;color:$(color);font-size:$(sz2)pt;\">$(txt2)</$(env)><br>
   </div>"
end

function show_html(txt;sz=20,color="darkred",justify="left",height=15,width=100,env="strong")
  display( HTML( to_html( txt; sz=sz, color=color, justify=justify, height=height, width=width, env=env ) ))
end
function show_html(txt1, txt2;sz1=20,sz2=20,color="darkred",justify="left",width=100,height=15, env="strong")
  txt = to_html(txt1, txt2;sz1=sz1,sz2=sz2,color=color,justify=justify,height=height,width=width,env=env)
  display( HTML(txt))
end

function pr(txt;sz=15,color="black",justify="left",height=15,width=100,env="p")
  show_html( txt;sz=sz,color=color,justify=justify,height=height,width=width,env=env)
end
