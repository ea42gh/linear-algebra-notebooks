<%*
let qcFileName = await tp.system.prompt("Note Title")
titleName      =  tp.date.now("YYYYMMDD") + "_" + qcFileName
await tp.file.rename(titleName)
await tp.file.move("/Topics/" + titleName);
-%>
---
title: <% qcFileName %>
tags:
topic:
up: [[INDEX]]
---
<% tp.file.cursor() %>
