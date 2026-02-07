using Pkg
Pkg.activate("/home/jovyan/.julia_env")
const GENERAL_REV = "182e674f3caa60a3c4f1fedb5ea093d131e304b5"
try
    # Ensure General exists, then pin to a known-good commit.
    Pkg.Registry.add("General")
    run(`git -C /home/jovyan/.julia/registries/General checkout $(GENERAL_REV)`)
catch
    # If add/checkout fails, proceed; build will surface the error.
end
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
    "Symbolics"            => :safe,
    "SymbolicUtils"        => :safe,

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
    "PlotlyJS"             => :gui,
    "Colors"               => :safe,
    "GR"                   => :gui,
    "Makie"                => :gui,
    "CairoMakie"           => :gui,
    "GLMakie"              => :gui,
    "WGLMakie"             => :gui,

    # Images / GTK stack
    "Images"               => :gui,
    "ImageShow"            => :gui,
    "ImageView"            => :gui,
    "TestImages"           => :gui,
    "MosaicViews"          => :gui,

    # Geometry / neighbors
    "NearestNeighbors"     => :safe,
    "AngleBetweenVectors"  => :safe,

    # Interactivity / dev
    "Interact"             => :gui,
    "WebIO"                => :gui,
    "Revise"               => :safe,
    "IOCapture"            => :safe,

    # text processing
    "Latexify"             => :safe,
    "LaTeXStrings"         => :safe,
    "StyledStrings"        => :safe,
    "HypertextLiteral"     => :safe,
    "IOCapture"            => :safe,

    # python, julia kernel and pluto
    "IJulia"               => :gui,
    "Pluto"                => :gui,
    "PythonCall"           => :gui,
)

safe_pkgs = [name for (name, kind) in pkgs if kind === :safe]

@info "Adding safe packages"
Pkg.add(safe_pkgs)

@info "Precompiling safe packages"
Pkg.precompile()

gui_pkgs = [name for (name, kind) in pkgs if kind === :gui]

@info "Adding GUI / non-safe packages (no precompile)"
Pkg.add(gui_pkgs)
