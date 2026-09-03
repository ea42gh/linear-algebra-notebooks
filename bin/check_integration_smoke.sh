#!/usr/bin/env bash
set -euo pipefail

JULIA_PROJECT_DIR="${ELA_JULIA_PROJECT:-/home/jovyan/.julia_env}"

python3 - <<'PY'
import LAFigureSpecs as lf
import matrixlayout  # noqa: F401
import sympy as sym
from matrixlayout.eigproblem import render_eig_svg
from matrixlayout.ge import render_ge_svg, render_ge_tex
from matrixlayout.qr import render_qr_svg

A = sym.Matrix([[1, 2], [3, 4]])
rhs = sym.Matrix([[5], [6]])
bundle = lf.ge_bundle(A, rhs=rhs, show_pivots=True)
assert "spec" in bundle
assert bundle["spec"]["n_rhs"] == 1
tex = render_ge_tex(**bundle["spec"])
assert "\\begin{NiceArray}" in tex
ge_svg = render_ge_svg(
    **bundle["spec"],
    output_dir="/tmp/ela-smoke",
    output_stem="ge_smoke",
)
assert ge_svg.lstrip().startswith("<svg")

qr = lf.qr_bundle([[1, 0], [0, 1]])
assert {"spec", "tex", "svg", "data", "render_error"}.issubset(qr)
qr_svg = render_qr_svg(
    **qr["spec"],
    output_dir="/tmp/ela-smoke",
    output_stem="qr_smoke",
)
assert qr_svg.lstrip().startswith("<svg")

for case, fn in (("S", lf.eig_bundle), ("SVD", lf.svd_bundle)):
    out = fn([[1, 0], [0, 1]])
    assert {"spec", "tex", "svg", "data", "render_error"}.issubset(out)
    eig_svg = render_eig_svg(
        out["spec"],
        case=case,
        output_dir="/tmp/ela-smoke",
        output_stem=case.lower() + "_smoke",
    )
    assert eig_svg.lstrip().startswith("<svg")

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