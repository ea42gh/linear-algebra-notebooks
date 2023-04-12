async function jupyterlink( nm, port) {
  // create a link for the notebook.ipynb  `nm`  for the server running on `port`
  return "[" + nm + "](" +
          "http://localhost:"+String(port) + "/lab/workspaces/auto-K/tree/NOTEBOOKS/file:///home/lab/NOTEBOOKS/elementary-linear-algebra/notebooks/" + nm +
          ")"
}

module.exports = jupyterlink;
