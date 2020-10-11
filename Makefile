.PHONY: git add all tellme

FILES := \
	LAcode.jl/src/LAcode.jl LAcode.jl/Project.toml LAcode.jl/Manifest.toml \
    01_ScalarsVectorsMatrices.ipynb \
    02_AddScalarMultDotprod.ipynb \
    03_MatrixMultiplication.ipynb \
    05_RowEchelonForm_Systems.ipynb \
    06_GE_Systems.ipynb \
    07_GE_Systems.ipynb \
    08_LinearIndependence.ipynb \
    09_LinearTransformations.ipynb \
    11_Inverses.ipynb \
    12_LU_decomposition.ipynb \
    \
    VectorAndMatrixNorms.ipynb \
    Basis.ipynb \
    CoordinateSystem.ggb CoordinateSystem.svg \
    EigenAnalysis.ipynb \
    ellipse.ggb ellipse.svg \
    FundamentalTheorem_0.ggb FundamentalTheorem_0.svg \
    FundamentalTheorem_1.ggb FundamentalTheorem_1.svg \
    FundamentalTheorem_2.ggb FundamentalTheorem_2.svg \
    FundamentalTheorem.ggb FundamentalTheorem.svg \
    GE_layout_display.ipynb \
    Inverses.ipynb \
    LAcodes.jl \
    LinearIndependence.ipynb \
    LinearTxExamples.ipynb \
    LinTxCd.svg \
    LinTxSymLine.svg \
    LU.ipynb \
    Makefile \
    NormalEquations.svg \
    Orthogonality.ipynb \
    OrthogonalProjection.ggb OrthogonalProjection.svg \
    OrthogonalReflection.ggb OrthogonalReflection.svg \
    README.md \
    Rotation.ggb Rotation.svg \
    subspace.ggb subspace.svg \
    Summary_01_MatrixMultiplication.ipynb \
    SymbolicVariables.ipynb \
    VectorSpaces.ipynb \
	VectorSumDiff.ggb VectorSumDiff.svg \
    EigenExample_1.ggb EigenExample_1.svg \
    EigenExample_1a.ggb EigenExample_1a.svg \
    EigenExample_2.ggb EigenExample_2.png \
    salzburg.jpeg SalzburgBasis.ggb  SalzburgBasis.png \
	ChangeOfBasis.ggb ChangeOfBasis.svg \
    Diagonalization.ipynb \
	TransformAction.ggb TransformAction.png \
	NormalEqMinDist.svg NormalEqMinDist.ggb \
	EigenComputations.ipynb \
    LengthOrthogonality.ipynb \
    OrthogonalDirection.ggb OrthogonalDirection.svg \
	VennDiagram_AtA.ggb  VennDiagram_AtA.svg \
	NormalProjOntoLine.ggb NormalProjOntoLine.svg \
	NormAndDistance.ggb NormAndDistance.svg \
	OrthoProjection_into_plane.ggb OrthoProjection_into_plane.png \
	GramSchmidt.ggb GramSchmidt.png \
	NormalEquation.ipynb \
	QR_Decomposition.ipynb \
	SVD.ipynb \
	SVD_ranks.ggb SVD_ranks.svg \
	SVDaction.ggb SVDaction.svg \
	PseudoInverse.svg \
	MetricSpaces.ipynb \
	QuadricSurfaceDisplay.ipynb \
    SpectralTheoremExample.ggb  SpectralTheoremExample.png \
   	SpectralTheorem.ipynb \
	QRonEigenvectors.png \
	IterativeMethods.ipynb \
	PositiveDefiniteMatrices.ipynb \
    augmented_matrix_1.tex augmented_matrix_1.svg \
    rowechelon_form.tex rowechelon_form.svg \
    tex2svg xetex2svg \
    augmented_matrix_2.tex augmented_matrix_2.svg \
    augmented_matrix_3.tex augmented_matrix_3.svg \
    textosvg.py \
    ge_simple_2.tex     ge_simple_2.svg   \
    ge_simple_1.tex     ge_simple_1.svg   \
    ge_complete_2.tex   ge_complete_2.svg \
    ge_complete_1.tex   ge_complete_1.svg \
    ge_missing_pivot_0.tex ge_missing_pivot_0.svg   \
    ge_pivot_underneath.tex ge_pivot_underneath.svg   \
    ge_no_pivot_0.tex ge_no_pivot_0.svg   \
    ge_no_pivot_1.tex ge_no_pivot_1.svg   \
    ge_zero_row_0.tex ge_zero_row_0.svg   \
    ge_zero_row_1.tex ge_zero_row_1.svg   \
	ge_where_to_move_to.svg ge_where_to_move_to.tex \
    ge_example_1.tex \
	ge_example_1b.svg  ge_example_1c.svg  ge_example_1d.svg  ge_example_1.svg \
	ge_example_2.svg  ge_example_2.tex \
	ge_num_solutions.svg  ge_num_solutions.tex \
	gj_example.svg  gj_example.tex \
	gj_example_1.svg  gj_example_1.tex \
	sol_rhs_1.svg sol_rhs_1.tex sol_rhs_2.svg sol_rhs_2.tex \
	sol_with_parameters.tex sol_with_parameters.svg \
	lin_dep_2.svg  lin_dep_2.tex lin_dep_1.svg  lin_dep_1.tex \
	lintx_1.svg  lintx_1.tex \
	lintx_2.svg  lintx_2.tex \
	cat.png  cat_upside_down.png \
	lu_multiple_rhs.svg  lu_multiple_rhs.tex \
	abstract_matrix_stack.svg  abstract_matrix_stack.tex \
	lu_prod_E.svg  lu_prod_E.tex \
	lu_prod_Ei.svg  lu_prod_Ei.tex \
	lu_example.svg  lu_example.tex \
	lu_example_b1_1.svg lu_example_b1_1.tex \
	lu_example_b1_2.svg lu_example_b1_2.tex \
	lu_example_b1_3.svg lu_example_b1_3.tex \
	lu_example_b1_4.svg lu_example_b1_4.tex \
	lu_example_b1_5.svg lu_example_b1_5.tex \
	lu_example_b1_6.svg lu_example_b1_6.tex \
	lu_example_b1_systeme.tex lu_example_b1_systeme.svg \
    $(eof)
#MISSING ge_example_1b.tex  ge_example_1c.tex  ge_example_1d.tex

all_notebooks.tgz:  $(FILES)
	@-tar cvfz all_notebooks.tgz $(FILES)

add:
	@git add $(FILES)

git:
	@git commit $(FILES)
	git push

all: add git all_notebooks.tgz

tellme:
	@echo make add git
