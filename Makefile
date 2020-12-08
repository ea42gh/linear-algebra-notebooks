.PHONY: git add all tellme
vpath %.svg Figs
vpath %.jpeg Figs
vpath %.tex Figs
vpath %.ggb Figs
vpath %.png Figs

# -------------------------------------------------------------------------------------
NOTEBOOKS := \
    01_ScalarsVectorsMatrices.ipynb       \
    02_AddScalarMultDotprod.ipynb         \
    03_MatrixMultiplication.ipynb         \
    04_MatrixAlgebra.ipynb                \
    05_RowEchelonForm_Systems.ipynb       \
    06_GE_Systems.ipynb                   \
    07_GE_Systems.ipynb                   \
    08_LinearIndependence.ipynb           \
    09_LinearTransformations.ipynb        \
    11_Inverses.ipynb                     \
    12_LU_decomposition.ipynb             \
    13_WedgeProduct.ipynb                 \
    14_Determinants.ipynb                 \
    15_VectorSpaces.ipynb                 \
    16_Basis.ipynb                        \
    17_EigenAnalysis.ipynb                \
	18_EigenComputations.ipynb            \
    19_Diagonalization.ipynb              \
    20_LengthOrthogonality.ipynb          \
	21_ProjectionsGramSchmidt.ipynb       \
    22_QR_Decomposition.ipynb             \
    23_MetricSpaces.ipynb                 \
    \
    GE_layout_display.ipynb               \
    Inverses.ipynb                        \
    IterativeMethods.ipynb                \
    LAcodes.jl                            \
    LinearIndependence.ipynb              \
    LinearTxExamples.ipynb                \
    LU.ipynb                              \
    Orthogonality.ipynb                   \
    PositiveDefiniteMatrices.ipynb        \
    QuadricSurfaceDisplay.ipynb           \
    SpectralTheorem.ipynb                 \
    Summary_01_MatrixMultiplication.ipynb \
    SymbolicVariables.ipynb               \
	$(eof)

# -------------------------------------------------------------------------------------
OTHER_FILES := \
    README.md                                                              \
    Makefile                                                               \
    LAcode.jl/src/LAcode.jl LAcode.jl/Project.toml LAcode.jl/Manifest.toml \
    Figs/Determinants.tex Figs/beamerikz.cls                               \
    tex2svg                                                                \
    xetex2svg                                                              \
	$(eof)

# -------------------------------------------------------------------------------------
TEX_FIG_SRCS := \
	abstract_matrix_stack.tex \
	augmented_matrix_1.tex    \
	augmented_matrix_2.tex    \
	augmented_matrix_3.tex    \
	mat_mult_ex1.tex          \
	mat_mult_ex1_v.tex        \
	mat_mult_ex3.tex          \
	mat_mult_ex4.tex          \
	mat_mult_ex5.tex          \
	mat_alg1.tex              \
	mat_alg2.tex              \
	mat_alg3.tex              \
	mat_alg4.tex              \
	mat_alg5.tex              \
	mat_alg6.tex              \
	det_AB.tex                \
	det_cramer_slide.tex      \
	det_distributivity.tex    \
	det_distributivity_1.tex  \
	det_slides.tex            \
	det_transpose_slides.tex  \
	det_using_ge.tex          \
	det_wedge_ex1.tex         \
	det_wedge_idea.tex        \
	det_wedge_orientation.tex \
	det_wedge_scalefact.tex   \
	ge_complete_1.tex         \
	ge_complete_2.tex         \
	ge_example_1.tex          \
	ge_example_2.tex          \
	ge_missing_pivot_0.tex    \
	ge_no_pivot_0.tex         \
	ge_no_pivot_1.tex         \
	ge_num_solutions.tex      \
	ge_pivot_underneath.tex   \
	ge_simple_1.tex           \
	ge_simple_2.tex           \
	ge_where_to_move_to.tex   \
	ge_zero_row_0.tex         \
	ge_zero_row_1.tex         \
	gj_example_1.tex          \
	gj_example.tex            \
	lin_dep_1.tex             \
	lin_dep_2.tex             \
	lintx_1.tex               \
	lintx_2.tex               \
	lu_example_b1_1.tex       \
	lu_example_b1_2.tex       \
	lu_example_b1_3.tex       \
	lu_example_b1_4.tex       \
	lu_example_b1_5.tex       \
	lu_example_b1_6.tex       \
	lu_example_b1_systeme.tex \
	lu_example_b2_1.tex       \
	lu_example_b2_2.tex       \
	lu_example_b2_3.tex       \
	lu_example_b2_4.tex       \
	lu_example_b2_5.tex       \
	lu_example_b2_6.tex       \
	lu_example_b2_systeme.tex \
	lu_example.tex            \
	lu_multiple_rhs.tex       \
	lu_prod_Ei.tex            \
	lu_prod_E.tex             \
	rowechelon_form.tex       \
	sol_rhs_1.tex             \
	sol_rhs_2.tex             \
	sol_with_parameters.tex   \
	qr_layout_1.tex           \
	qr_layout_1_error.tex     \
	qr_layout_2.tex           \
	qr_layout_3.tex           \
	$(eog)

# -------------------------------------------------------------------------------------
GGB_PNG_FIG_SRCS :=            \
	EigenExample_2.ggb             \
	GramSchmidt.ggb                \
	OrthoProjection_into_plane.ggb \
	SalzburgBasis.ggb              \
	SpectralTheoremExample.ggb     \
	TransformAction.ggb            \
	$(eog)

GGB_SVG_FIG_SRCS :=      \
	ChangeOfBasis.ggb        \
	CoordinateSystem.ggb     \
	EigenExample_1a.ggb      \
	EigenExample_1.ggb       \
	ellipse.ggb              \
	FundamentalTheorem_0.ggb \
	FundamentalTheorem_1.ggb \
	FundamentalTheorem_2.ggb \
	FundamentalTheorem.ggb   \
	NormalEqMinDist.ggb      \
	NormalProjOntoLine.ggb   \
	NormAndDistance.ggb      \
	OrthogonalDirection.ggb  \
	OrthogonalProjection.ggb \
	OrthogonalReflection.ggb \
	Rotation.ggb             \
	subspace.ggb             \
	SVDaction.ggb            \
	SVD_ranks.ggb            \
	VectorSumDiff.ggb        \
	VennDiagram_AtA.ggb      \
	$(eof)
# -------------------------------------------------------------------------------------
OTHER_FIGS := \
	cat.png              \
	cat_upside_down.png  \
	ge_example_1a.svg    \
	ge_example_1b.svg    \
	ge_example_1c.svg    \
	ge_example_1d.svg    \
    LinTxCd.svg          \
    LinTxSymLine.svg     \
    NormalEquations.svg  \
    PseudoInverse.svg    \
	QRonEigenvectors.png \
	salzburg.jpeg        \
	$(eof)

# =============================================================================================
# Derived variables
# -------------------------------------------------------------------------------------
FIGS_SVG_FROM_TEX_FILES := $(TEX_FIG_SRCS:.tex=.svg)
FIGS_PNG_FROM_GGB       := $(GGB_PNG_FIG_SRCS:.ggb=.png)
FIGS_SVG_FROM_GGB       := $(GGB_SVG_FIG_SRCS:.ggb=.svg)

ALL_FIGS                := $(addprefix Figs/, $(FIGS_SVG_FROM_GGB) $(FIGS_PNG_FROM_GGB) $(FIGS_SVG_FROM_TEX_FILES) $(OTHER_FIGS))
ALL_FIG_SRCS            := $(addprefix Figs/, $(TEX_FIG_SRCS) $(GGB_PNG_FIG_SRCS) $(GGB_SVG_FIG_SRCS))

ALL_FILES               := $(NOTEBOOKS) $(ALL_FIGS) $(ALL_FIG_SRCS) $(OTHER_FILES)
# =============================================================================================

all_notebooks.tgz:  $(ALL_FILES)
	@-tar cvfz all_notebooks.tgz $(ALL_FILES)

add:
	@git add $(ALL_FILES)

git:
	@git commit $(ALL_FILES)
	git push

all: add git all_notebooks.tgz

tellme:
	@echo make add git all_notebooks.tgz
