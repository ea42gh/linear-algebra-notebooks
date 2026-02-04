#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <notebook.ipynb>" >&2
  exit 1
fi

NB="$1"

python - <<'PY' "$NB"
import json
import subprocess
import sys
from pathlib import Path

nb_path = Path(sys.argv[1])
data = json.loads(nb_path.read_text())

ks = data.get("metadata", {}).get("kernelspec", {})
name = ks.get("name", "<none>")
display_name = ks.get("display_name", "<none>")
lang = ks.get("language", "<none>")

print(f"Notebook: {nb_path}")
print(f"Kernel: name={name!r}, display_name={display_name!r}, language={lang!r}")

try:
    out = subprocess.check_output(["jupyter", "kernelspec", "list", "--json"], text=True)
    kernels = json.loads(out).get("kernelspecs", {})
    if name and name not in kernels:
        print(f"⚠ Missing kernel: {name}")
        print("  Suggestion: install/register that kernel or edit kernelspec in the notebook.")
except Exception as e:
    print(f"⚠ Could not query jupyter kernels: {e}")

imports = set()
for cell in data.get("cells", []):
    if cell.get("cell_type") != "code":
        continue
    src = "".join(cell.get("source", []))
    for line in src.splitlines():
        line = line.strip()
        if line.startswith("import ") or line.startswith("from "):
            imports.add(line)

py_imports = [i for i in imports if "import" in i]
if py_imports:
    print("\nDetected Python imports:")
    for i in sorted(py_imports):
        print(" ", i)
    hints = []
    if any("la_figures" in i for i in py_imports):
        hints.append("export PYTHONPATH=/opt/ea42gh/la_figures:$PYTHONPATH")
    if any("matrixlayout" in i for i in py_imports):
        hints.append("export PYTHONPATH=/opt/ea42gh/matrixlayout:$PYTHONPATH")
    if hints:
        print("\nLikely fixes:")
        for h in hints:
            print(" ", h)

errs = []
for i, cell in enumerate(data.get("cells", [])):
    if cell.get("cell_type") != "code":
        continue
    for out in cell.get("outputs", []):
        if out.get("output_type") == "error":
            errs.append((i, out.get("ename"), out.get("evalue")))
if errs:
    print("\nRecorded errors in notebook:")
    for idx, ename, evalue in errs[-5:]:
        print(f"  cell {idx}: {ename}: {evalue}")
else:
    print("\nNo recorded errors in notebook outputs.")
PY
