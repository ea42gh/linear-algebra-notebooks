FILES := \
    README.md	\
    LAcodes.jl	\
    SymbolicVariables.ipynb	\
    GE_layout_display.ipynb	\
   	\
    MatrixMultiplication.ipynb	\
    Inverses.ipynb	\
    LU.ipynb	\
    LinearIndependence.ipynb	\
    Basis.ipynb	\
    LinearTxExamples.ipynb	\
    LinTxCd.svg	\
    LinTxSymLine.svg	\
    NormalEquations.svg	\
    Orthogonality.ipynb	\
    $(eof)

all_notebooks.tgz:  $(FILES)
	@-tar cvfz all_notebooks.tgz $(FILES)
