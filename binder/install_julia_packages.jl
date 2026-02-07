using Pkg
Pkg.activate("/home/jovyan/.julia_env")

# Always refresh the General registry for a clean, up-to-date install.
rm("/home/jovyan/.julia/registries/General"; force=true, recursive=true)
Pkg.Registry.add("General")
Pkg.instantiate()

@info "Adding QuadGK from URL (pinned)"
try
    Pkg.add(url="https://github.com/JuliaMath/QuadGK.jl", rev="v2.4.2")
catch
    # If this fails, continue; build will surface the error later.
end

pkgs = Dict(
    # Algebra / numerics
    "AbstractAlgebra"      => :safe,
    "BlockArrays"          => :safe,
    "SparseArrays"         => :safe,
    "LinearAlgebra"        => :safe,
    "ToeplitzMatrices"     => :safe,
    "Hadamard"             => :safe,
    # Installed separately from a pinned URL to avoid registry issues.
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
