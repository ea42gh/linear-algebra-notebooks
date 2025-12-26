using Pkg

Pkg.update()

pkgs = Dict(
    # Algebra / numerics
    "AbstractAlgebra"      => :safe,
    "BlockArrays"          => :safe,
    "GenericLinearAlgebra" => :safe,
    "LinearAlgebra"        => :safe,
    "Hadamard"             => :safe,
    "QuadGK"               => :safe,

    # Transforms / analysis
    "FFTW"                 => :safe,
    "DSP"                  => :safe,
    "ToeplitzMatrices"     => :safe,
    "Polynomials"          => :safe,

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
    "PrettyTables"         => :safe,
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

    # Interactivity / dev
    "Interact"             => :gui,
    "PythonCall"           => :safe,
    "Revise"               => :safe,
    "IOCapture"            => :safe,
)

Pkg.add(collect(keys(pkgs)))

for (pkg, kind) in pkgs
    kind === :safe || continue
    @info "Precompiling $pkg"
    Pkg.precompile(pkg)
end

