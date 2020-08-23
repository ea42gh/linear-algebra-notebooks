.PHONY: git add all

FILES := \
	LAcode.jl/src/LAcode.jl LAcode.jl/Project.toml LAcode.jl/Manifest.toml \
    01_ScalarsVectorsMatrices.ipynb \
    02_AddScalarMultDotprod.ipynb \
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
    03_MatrixMultiplication.ipynb \
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
    03_MatrixMultiplication.ipynb \
    augmented_matrix_1.tex augmented_matrix_1.svg \
    rowechelon_form.tex rowechelon_form.svg \
    tex2svg \
    augmented_matrix_2.tex augmented_matrix_2.svg \
    augmented_matrix_3.tex augmented_matrix_3.svg \
    textosvg.py \
    04_RowEchelonForm_Systems.ipynb \
    05_GE_Systems.ipynb \
    $(eof)

all_notebooks.tgz:  $(FILES)
	@-tar cvfz all_notebooks.tgz $(FILES)

add:
	git add $(FILES)

git:
	git commit $(FILES)
	git push

all: add git all_notebooks.tgz
