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
    "IOCapture" => :safe,
    "Latexify" => :safe,
    "LaTeXStrings" => :safe,
    "StyledStrings" => :safe,
    "HypertextLiteral" => :safe,

    "Images" => :safe,
    "ImageShow" => :safe,
    "TestImages" => :safe,
    "MosaicViews" => :safe,
    "WebIO" => :safe,
    "IJulia" => :safe,

    # Blocked: packages that should not be precompiled on headless builds.
    "StatsPlots" => :blocked,
    "Plots" => :blocked,
    "PlotlyJS" => :blocked,
    "GR" => :blocked,
    "Makie" => :blocked,
    "CairoMakie" => :blocked,
    "GLMakie" => :blocked,
    "WGLMakie" => :blocked,
    "ImageView" => :blocked,
    "Interact" => :blocked,
    "Pluto" => :blocked,
    "PythonCall" => :safe,
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
