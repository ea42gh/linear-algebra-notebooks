<%*
// add a link from the clipboard to a note
//  Usage: copy a link to the clipboard
//               select and execute the script  (e.g., use <Alt e> )
// --------------------------------------------------------------–
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
