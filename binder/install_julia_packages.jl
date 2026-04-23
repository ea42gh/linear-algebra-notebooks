using Pkg

Pkg.activate("/home/jovyan/.julia_env")
# Enforce policy: only explicitly precompile the :safe set.
ENV["JULIA_PKG_PRECOMPILE_AUTO"] = "0"

# Ensure the General registry is available.
Pkg.Registry.add("General")

# Resolve any existing deps in the environment.
Pkg.instantiate()

# Package list with headless-precompile eligibility.
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
    "PrecompileTools" => :safe,
    "IOCapture" => :safe,
    "Latexify" => :safe,
    "LaTeXStrings" => :safe,
    "StyledStrings" => :safe,
    "HypertextLiteral" => :safe,
    "PythonCall" => :safe,

    # Safe: notebook, web, image, and plotting packages that precompile
    # without opening a native display window in the Binder build.
    "Images" => :safe,
    "ImageShow" => :safe,
    "TestImages" => :safe,
    "MosaicViews" => :safe,
    "WebIO" => :safe,
    "IJulia" => :safe,
    "Interact" => :safe,
    "Pluto" => :safe,
    "Plots" => :safe,
    "StatsPlots" => :safe,
    "PlotlyJS" => :safe,
    "GR" => :safe,
    "Makie" => :safe,
    "CairoMakie" => :safe,
    "WGLMakie" => :safe,

    # Blocked: native display-window stacks. Install them for runtime use, but
    # avoid explicit precompile in the headless image build.
    "GLMakie" => :blocked,
    "ImageView" => :blocked,
)

safe_pkgs = [name for (name, kind) in pkgs if kind === :safe]
blocked_pkgs = [name for (name, kind) in pkgs if kind === :blocked]

open("/home/jovyan/.julia_env_blocked_pkgs.txt", "w") do io
    for name in sort(blocked_pkgs)
        println(io, name)
    end
end

Pkg.add(safe_pkgs)
Pkg.precompile(safe_pkgs; strict=false)

Pkg.add(blocked_pkgs)
