# Docs Overview

This directory collects the published documentation for the linear-algebra stack.

- jupyter-tikz: Engine to render LaTeX documents in Jupyter
- matrixlayout: Python layout engine for matrix/table TeX and SVG (uses jupyter-tikz)
  - grid_tex / grid_svg: render GE-style matrix grids from specs
  - qr_grid_tex / qr_grid_svg: render QR layout grids
  - eigproblem_tex / eigproblem_svg: render eigen/SVD tables from specs
  - backsubst_tex / backsubst_svg: render substitution cascades and systems
  - make_decorator / decorate_tex_entries: per-entry TeX decoration helpers

- la_figures: Python algorithms that emit layout specs consumed by matrixlayout.
  - ge / ge_tbl_spec / ge_tbl_bundle: GE layout + spec helpers
  - qr_svg / qr_tbl_spec / gram_schmidt_qr: QR layout + Gram–Schmidt helpers
  - eig_tbl_spec / eig_tbl_svg / eigproblem_svg: eigen table specs + render
  - svd_tbl_spec / svd_tbl_svg: SVD table specs + render
  - linear_system_tex / backsubstitution_tex / standard_solution_tex: system and cascade TeX
  - show_svg: display an SVG string in notebooks

- LAlatex: Convert Julia objects to TeX and render them in a Jupyter notebook
  - l_show / L_show: main display entry points
  - to_latex: convert objects to TeX
  - pr: styled text display helper
  - set_backend! / import_sympy / syms_sympy: symbolic backend + SymPy access
  - rowechelon_formatter / make_decorator: per-entry formatting helpers

- GenLAProblems: Julia generators for linear-algebra problems and solution steps.
  - gen_gj_pb / gen_lu_pb / gen_ldlt_pb / gen_svd_problem: problem generators
  - reduce_to_ref / decorate_ge: GE steps + layout metadata
  - ShowGe / ref! / show_layout!: GE notebook workflow
  - show_system / show_backsubstitution! / show_solution!: system/cascade/solution views
  - nM.ge / nM.show_ge_tbl / nM.show_qr_tbl: Python-backed renderers
