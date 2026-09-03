using Pkg

Pkg.activate("/home/jovyan/.julia_env")
# Enforce policy: only explicitly precompile the :safe set.
ENV["JULIA_PKG_PRECOMPILE_AUTO"] = "0"

# Ensure the General registry is available.
Pkg.Registry.add("General")

# Resolve any existing deps in the environment.
Pkg.instantiate()

# Package list with headless-precompile eligibility and precompile block ids.
pkg_specs = Dict(
    # Safe: core math/data packages that should precompile on headless builds.
    "AbstractAlgebra" => (phase=:safe, block=:core),
    "BlockArrays" => (phase=:safe, block=:core),
    "SparseArrays" => (phase=:safe, block=:core),
    "GenericLinearAlgebra" => (phase=:safe, block=:core),
    "LinearAlgebra" => (phase=:safe, block=:core),
    "ToeplitzMatrices" => (phase=:safe, block=:core),
    "Hadamard" => (phase=:safe, block=:core),
    "QuadGK" => (phase=:safe, block=:core),
    "Random" => (phase=:safe, block=:core),
    "RowEchelon" => (phase=:safe, block=:core),
    "Symbolics" => (phase=:safe, block=:core),
    "SymbolicUtils" => (phase=:safe, block=:core),
    "FFTW" => (phase=:safe, block=:core),
    "DSP" => (phase=:safe, block=:core),
    "Polynomials" => (phase=:safe, block=:core),
    "Distributions" => (phase=:safe, block=:core),
    "StatsBase" => (phase=:safe, block=:core),
    "CSV" => (phase=:safe, block=:core),
    "DataFrames" => (phase=:safe, block=:core),
    "RDatasets" => (phase=:safe, block=:core),
    "Colors" => (phase=:safe, block=:core),
    "PrettyTables" => (phase=:safe, block=:core),
    "NearestNeighbors" => (phase=:safe, block=:core),
    "AngleBetweenVectors" => (phase=:safe, block=:core),
    "Revise" => (phase=:safe, block=:core),
    "PrecompileTools" => (phase=:safe, block=:core),
    "IOCapture" => (phase=:safe, block=:core),
    "Latexify" => (phase=:safe, block=:core),
    "LaTeXStrings" => (phase=:safe, block=:core),
    "StyledStrings" => (phase=:safe, block=:core),
    "HypertextLiteral" => (phase=:safe, block=:core),
    "PythonCall" => (phase=:safe, block=:core),

    # Safe: notebook and image helpers.
    "Images" => (phase=:safe, block=:notebook),
    "ImageShow" => (phase=:safe, block=:notebook),
    "TestImages" => (phase=:safe, block=:notebook),
    "MosaicViews" => (phase=:safe, block=:notebook),
    "WebIO" => (phase=:safe, block=:notebook),
    "IJulia" => (phase=:safe, block=:notebook),
    "Interact" => (phase=:safe, block=:notebook),
    "Pluto" => (phase=:safe, block=:notebook),

    # Safe: plotting stack, but expensive enough to isolate.
    "Plots" => (phase=:safe, block=:plots),
    "StatsPlots" => (phase=:safe, block=:plots),
    "PlotlyJS" => (phase=:safe, block=:plots),
    "PlotlyBase" => (phase=:safe, block=:plots),
    "JSON3" => (phase=:safe, block=:plots),
    "GR" => (phase=:safe, block=:plots),

    # Safe but especially memory-heavy.
    "Makie" => (phase=:safe, block=:makie),
    "CairoMakie" => (phase=:safe, block=:makie),
    "WGLMakie" => (phase=:safe, block=:makie),

    # Blocked: native display-window stacks. Install them for runtime use, but
    # avoid explicit precompile in the headless image build.
    "GLMakie" => (phase=:blocked, block=:blocked),
    "ImageView" => (phase=:blocked, block=:blocked),
)

function pythoncall_spec(name::String)
    version_file = "/tmp/pythoncall_jl_version"
    if isfile(version_file)
        version = String(strip(read(version_file, String)))
        return Pkg.PackageSpec(name=name, version=version)
    end
    return Pkg.PackageSpec(name=name)
end
safe_pkgs = [
    name == "PythonCall" ? pythoncall_spec(name) : Pkg.PackageSpec(name=name)
    for (name, spec) in pkg_specs if spec.phase === :safe
]
blocked_pkgs = [name for (name, spec) in pkg_specs if spec.phase === :blocked]
precompile_blocks = Dict{Symbol, Vector{String}}()
for (name, spec) in pkg_specs
    spec.phase === :safe || continue
    push!(get!(precompile_blocks, spec.block, String[]), name)
end

open("/home/jovyan/.julia_env_blocked_pkgs.txt", "w") do io
    for name in sort(blocked_pkgs)
        println(io, name)
    end
end

mkpath("/home/jovyan/.julia_env_precompile_blocks")
for (block, names) in sort!(collect(precompile_blocks); by=first)
    open("/home/jovyan/.julia_env_precompile_blocks/$(block).txt", "w") do io
        for name in sort(names)
            println(io, name)
        end
    end
end

Pkg.add(safe_pkgs)
for block in (:core, :notebook, :plots, :makie)
    pkgs = get(precompile_blocks, block, String[])
    isempty(pkgs) && continue
    Pkg.precompile(pkgs; strict=false)
end

Pkg.add(blocked_pkgs)
