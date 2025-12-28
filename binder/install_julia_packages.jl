using Pkg
Pkg.activate("/home/jovyan/.julia_env")
Pkg.instantiate()


pkgs = Dict(
    # Algebra / numerics
    "AbstractAlgebra"      => :safe,
    "BlockArrays"          => :safe,
    "SparseArrays"         => :safe,
    "GenericLinearAlgebra" => :safe,
    "LinearAlgebra"        => :safe,
    "ToeplitzMatrices"     => :safe,
    "Hadamard"             => :safe,
    "QuadGK"               => :safe,
    "Random"               => :safe,
    "RowEchelon"           => :safe,

    # Transforms / analysis
    "FFTW"                 => :safe,
    "DSP"                  => :safe,
    "ToeplitzMatrices"     => :safe,
    "Polynomials"          => :safe,
    "Hadamard"             => :safe,

    # Probability / statistics / data
    "Distributions"        => :safe,
    "StatsBase"            => :safe,
    "StatsPlots"           => :gui,
    "CSV"                  => :safe,
    "DataFrames"           => :safe,
    "RDatasets"            => :safe,

    # Plotting / tables / colors
    "Plots"                => :gui,
    #"PlotlyJS"             => :gui,
    "Colors"               => :safe,
    "PrettyTables"         => :safe,
    "HtmlDecoration"       => :safe,
    "GR"                   => :gui,
    "Makie"                => :gui,
    "CairoMakie"           => :gui,
    "GLMakie"              => :gui,
    "WGLMakie"             => :gui,

    # Images / GTK stack
    "Images"               => :gui,
    "ImageView"            => :gui,
    "TestImages"           => :gui,
    "MosaicViews"          => :gui,

    # Geometry / neighbors
    "NearestNeighbors"     => :safe,
    "AngleBetweenVectors"  => :safe,

    # Interactivity / dev
    "Interact"             => :gui,
    "PythonCall"           => :safe,
    "Revise"               => :safe,
    "IOCapture"            => :safe,

    # tet processing
    "Latexify"             => :safe,
    "LaTeXStrings"         => :safe,
    "StyledStrings"        => :safe,
    "HypertextLiteral"     => :safe,
    "IOCapture"            => :safe,

    # python, julia kernel and pluto
    "PythonCall"           => :safe,
    "IJulia"               => :gui,
    "Pluto"                => :gui,
)

safe_pkgs = [name for (name, kind) in pkgs if kind === :safe]

@info "Adding safe packages"
Pkg.add(safe_pkgs)

@info "Precompiling safe packages"
Pkg.precompile()

gui_pkgs = [name for (name, kind) in pkgs if kind === :gui]

@info "Adding GUI / non-safe packages (no precompile)"
Pkg.add(gui_pkgs)
