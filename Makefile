.PHONY: git add all

FILES := \
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
    MatrixMultiplication.ipynb \
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
    EigenExample_1.ggb EigenExample_1.svg \
    EigenExample_1a.ggb EigenExample_1a.svg \
    EigenExample_2.ggb EigenExample_2.png \
    EigenAnalysis.ipynb \
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
	OrthoProjection_into_plane.ggb OrthoProjection_into_plane.png \
	GramSchmidt.ggb GramSchmidt.png \
	NormalEquation.ipynb \
    $(eof)

all_notebooks.tgz:  $(FILES)
	@-tar cvfz all_notebooks.tgz $(FILES)

add:
	git add $(FILES)

git:
	git commit $(FILES)
	git push

all: add git all_notebooks.tgz
