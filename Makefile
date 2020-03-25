.PHONY: git

FILES := \
    Basis.ipynb \
    CoordinateSystem.ggb \
    CoordinateSystem.svg \
    EigenAnalysis.ipynb \
    ellipse.ggb \
    ellipse.svg \
    FundamentalTheorem_0.ggb \
    FundamentalTheorem_0.svg \
    FundamentalTheorem_1.ggb \
    FundamentalTheorem_1.svg \
    FundamentalTheorem_2.ggb \
    FundamentalTheorem_2.svg \
    FundamentalTheorem.ggb \
    FundamentalTheorem.svg \
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
    OrthogonalProjection.ggb \
    OrthogonalProjection.svg \
    OrthogonalReflection.ggb \
    OrthogonalReflection.svg \
    README.md \
    Rotation.ggb \
    Rotation.svg \
    subspace.ggb \
    subspace.svg \
    Summary_01_MatrixMultiplication.ipynb \
    SymbolicVariables.ipynb \
    VectorSpaces.ipynb \
    $(eof)

all_notebooks.tgz:  $(FILES)
	@-tar cvfz all_notebooks.tgz $(FILES)

git:
	git commit $(FILES)
