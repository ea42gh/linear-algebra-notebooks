using Pkg

Pkg.activate("/home/jovyan/.julia_env")
# Enforce policy: only explicitly precompile the :safe set.
ENV["JULIA_PKG_PRECOMPILE_AUTO"] = "0"

# Ensure the General registry is available.
Pkg.Registry.add("General")

# Resolve any existing deps in the environment.
Pkg.instantiate()

# Package list with precompile eligibility.
# Keep the union of the older list (safe/gui split) and the current list.
pkgs = Dict(
    # Safe: core math/data packages that should precompile on headless builds.
    "AbstractAlgebra" => :safe,
    "BlockArrays" => :safe,
    "SparseArrays" => :safe,
    "GenericLinearAlgebra" => :safe,
    "LinearAlgebra" => :safe,
    "ToeplitzMatrices" => :safe,
    "Hadamard" => :safe,
    "QuadGK" => :safe,
    "Random" => :safe,
    "RowEchelon" => :safe,
    "Symbolics" => :safe,
    "SymbolicUtils" => :safe,
    "FFTW" => :safe,
    "DSP" => :safe,
    "Polynomials" => :safe,
    "Distributions" => :safe,
    "StatsBase" => :safe,
    "CSV" => :safe,
    "DataFrames" => :safe,
    "RDatasets" => :safe,
    "Colors" => :safe,
    "PrettyTables" => :safe,
    "NearestNeighbors" => :safe,
    "AngleBetweenVectors" => :safe,
    "Revise" => :safe,
    "IOCapture" => :safe,
    "Latexify" => :safe,
    "LaTeXStrings" => :safe,
    "StyledStrings" => :safe,
    "HypertextLiteral" => :safe,

    # GUI: plotting/interactive packages; do not precompile in headless builds.
    "StatsPlots" => :gui,
    "Plots" => :gui,
    "PlotlyJS" => :gui,
    "GR" => :gui,
    "Makie" => :gui,
    "CairoMakie" => :gui,
    "GLMakie" => :gui,
    "WGLMakie" => :gui,
    "Images" => :gui,
    "ImageShow" => :gui,
    "ImageView" => :gui,
    "TestImages" => :gui,
    "MosaicViews" => :gui,
    "Interact" => :gui,
    "WebIO" => :gui,
    "IJulia" => :gui,
    "Pluto" => :gui,
    "PythonCall" => :safe,
)

safe_pkgs = [name for (name, kind) in pkgs if kind === :safe]
gui_pkgs = [name for (name, kind) in pkgs if kind === :gui]

Pkg.add(safe_pkgs)
Pkg.precompile(safe_pkgs; strict=false)

Pkg.add(gui_pkgs)
