#!/usr/bin/env bash
set -euo pipefail

JULIA_PROJECT_DIR="${ELA_JULIA_PROJECT:-/home/jovyan/.julia_env}"

python3 - <<'PY'
import LAFigureSpecs as lf
import matrixlayout  # noqa: F401
import sympy as sym
from matrixlayout.ge import render_ge_tex

A = sym.Matrix([[1, 2], [3, 4]])
rhs = sym.Matrix([[5], [6]])
bundle = lf.ge_bundle(A, rhs=rhs, show_pivots=True)
assert "spec" in bundle
assert bundle["spec"]["n_rhs"] == 1
tex = render_ge_tex(**bundle["spec"])
assert "\\begin{NiceArray}" in tex

for fn in (lf.qr_bundle, lf.eig_bundle, lf.svd_bundle):
    out = fn([[1, 0], [0, 1]])
    assert {"spec", "tex", "svg", "data", "render_error"}.issubset(out)

print("Python figure stack smoke OK")
PY

julia --project="$JULIA_PROJECT_DIR" -e '
using LinearAlgebra
using PythonCall
using LAlatex
using GenLAProblems
using LATeachingSuite

LATeachingSuite.load_LAFigureSpecs()
LATeachingSuite.load_matrixlayout()

A = [1 2; 3 4]
h, _ = qr_figure(A; output_dir="/tmp/ela-smoke", output_stem="qr_smoke")
isempty(String(h.svg)) && error("qr_figure returned empty SVG")

latex = LAlatex.L_show("x = ", 1)
isempty(String(latex)) && error("LAlatex returned empty output")

pb = ShowGE{Rational{Int}}(Rational{Int}.(A), Rational{Int}.([5; 6;;]))
ref!(pb; gj=false)
solutions(pb)

C = symbols_matrix("\\alpha", 1:2, 1:2)
size(C) == (2, 2) || error("symbols_matrix failed")

println("Julia bridge smoke OK")
'