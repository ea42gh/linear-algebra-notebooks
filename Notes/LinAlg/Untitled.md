async function jupyterlink( nm, port) {
  return "[" + nm + "](" +
          "http://localhost:"+String(port) + "/lab/workspaces/auto-K/tree/NOTEBOOKS/file:///home/lab/NOTEBOOKS/elementary-linear-algebra/notebooks/" + nm +
          ")"
}

module.exports = jupyterlink;
