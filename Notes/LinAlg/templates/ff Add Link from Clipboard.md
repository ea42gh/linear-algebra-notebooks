<%*
// add a note with a link copied from the clipboard
//  Usage: copy a link to the clipboard
//               select and execute the script  (e.g., use <Alt n> )
let url    = await tp.system.clipboard(); // Paste link
// let url = await tp.file.selection().trim(); // Replace selected link
let page = await tp.obsidian.request({url});

let p       = new DOMParser();
let doc   = p.parseFromString(page, "text/html");
let $       = s => doc.querySelector(s);
let title   = $("title")?.textContent || $("meta[property='title']")?.content;
let description      = $("meta[name='description']")?.content || $("meta[property = 'og:description']")?.content;
//---
//up: [[INDEX]]
//tags:
//---
-%>
##### <% title %>
<% description ? `${description}\n` : '' %>[<% title %>](<% url %>)