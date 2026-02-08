using Pkg
using Pkg.TOML
Pkg.activate("/home/jovyan/.julia_env")

# Always refresh the General registry for a clean, up-to-date install.
function _general_registry_path()
    reg_root = "/home/jovyan/.julia/registries"
    candidates = [
        joinpath(reg_root, "General"),
        joinpath(reg_root, "General.git"),
    ]
    for path in candidates
        if isfile(joinpath(path, "Registry.toml"))
            return path
        end
    end
    # If the registry was just added but the path isn't visible yet, try once more.
    try
        Pkg.Registry.add("General")
    catch
        # ignore and fall through to error
    end
    for path in candidates
        if isfile(joinpath(path, "Registry.toml"))
            return path
        end
    end
    # Fallback: search for a registry named "General"
    if isdir(reg_root)
        for entry in readdir(reg_root)
            path = joinpath(reg_root, entry)
            reg_file = joinpath(path, "Registry.toml")
            if isfile(reg_file)
                try
                    parsed = TOML.parsefile(reg_file)
                    if get(parsed, "name", nothing) == "General"
                        return path
                    end
                catch
                    # ignore parse errors
                end
            end
        end
    end
    error("General registry not found under $(reg_root)")
end

function _assert_versions(pkg, reg_path)
    vfile = joinpath(reg_path, uppercase(string(first(pkg))), pkg, "Versions.toml")
    isfile(vfile) || error("Missing Versions.toml for $(pkg)")
    raw = read(vfile, String)
    isempty(raw) && error("Empty Versions.toml for $(pkg)")
    parsed = TOML.parse(raw)
    isempty(parsed) && error("No versions listed in Versions.toml for $(pkg)")
end

function _has_versions(pkg, reg_path)
    try
        _assert_versions(pkg, reg_path)
        return true
    catch
        return false
    end
end

function _registry_ok(pkg, reg_path)
    _registry_has_pkg(pkg, reg_path) && _has_versions(pkg, reg_path)
end

function _refresh_registry()
    rm("/home/jovyan/.julia/registries/General"; force=true, recursive=true)
    Pkg.Registry.add("General")
end

function _max_version_for(pkg, reg_path)
    vfile = joinpath(reg_path, uppercase(string(first(pkg))), pkg, "Versions.toml")
    isfile(vfile) || return nothing
    parsed = TOML.parsefile(vfile)
    isempty(parsed) && return nothing
    vers = VersionNumber.(keys(parsed))
    isempty(vers) ? nothing : maximum(vers)
end

function _registry_has_pkg(pkg, reg_path)
    rfile = joinpath(reg_path, "Registry.toml")
    isfile(rfile) || return false
    parsed = TOML.parsefile(rfile)
    pkgs = get(parsed, "packages", Dict())
    for (_, info) in pkgs
        if info isa Dict && get(info, "name", nothing) == pkg
            return true
        end
    end
    return false
end

function _registry_is_fresh(reg_path)
    # Reject incomplete registry snapshots.
    for pkg in ("Distributions", "StatsBase", "DataFrames")
        if !_registry_has_pkg(pkg, reg_path)
            return false
        end
    end
    # Heuristic: require reasonably recent versions for a few common packages.
    v_csv = _max_version_for("CSV", reg_path)
    v_df = _max_version_for("DataFrames", reg_path)
    v_dist = _max_version_for("Distributions", reg_path)
    if v_csv === nothing || v_df === nothing || v_dist === nothing
        return false
    end
    return v_csv >= v"0.10.0" && v_df >= v"1.0.0" && v_dist >= v"0.25.0"
end

function _missing_registry_pkgs(pkgs, reg_path)
    missing = String[]
    for pkg in pkgs
        if pkg in _stdlib_pkgs
            continue
        end
        try
            _assert_versions(pkg, reg_path)
        catch
            push!(missing, pkg)
        end
    end
    return missing
end

function _registry_repo_map(reg_path)
    reg_file = joinpath(reg_path, "Registry.toml")
    parsed = TOML.parsefile(reg_file)
    pkgs = get(parsed, "packages", Dict())
    repo_map = Dict{String,String}()
    for (_, info) in pkgs
        if !(isa(info, Dict) && haskey(info, "name") && haskey(info, "path"))
            continue
        end
        pkg_name = info["name"]
        pkg_path = info["path"]
        pkg_toml = joinpath(reg_path, pkg_path, "Package.toml")
        if isfile(pkg_toml)
            try
                pkg_info = TOML.parsefile(pkg_toml)
                if haskey(pkg_info, "repo")
                    repo_map[pkg_name] = pkg_info["repo"]
                end
            catch
                # Ignore parse errors; explicit URL fallbacks still apply.
            end
        end
    end
    return repo_map
end

const _stdlib_pkgs = Set([
    "LinearAlgebra",
    "SparseArrays",
    "Random",
    "Printf",
    "Statistics",
    "Test",
])

function _add_with_retry(pkgs; tries=3, delay=5)
    for i in 1:tries
        try
            Pkg.add(pkgs)
            return
        catch
            if i == tries
                rethrow()
            end
            sleep(delay)
        end
    end
end

function _add_url_pkgs(pkgs; tries=3, delay=5, attempted=Set{String}())
    specs = [haskey(p, "rev") ? Pkg.PackageSpec(; url=p["url"], rev=p["rev"]) : Pkg.PackageSpec(; url=p["url"]) for p in pkgs]
    while true
        try
            _add_with_retry(specs; tries=tries, delay=delay)
            return
        catch e
            msg = sprint(showerror, e)
            if _fallback_from_error(msg; attempted=attempted)
                continue
            end
            rethrow()
        end
    end
end

function _missing_pkgs_from_error(msg::AbstractString)
    names = String[]
    rx = Regex("package\\s+([A-Za-z0-9_]+)\\s+\\[")
    for m in eachmatch(rx, msg)
        push!(names, m.captures[1])
    end
    return unique(names)
end

function _fallback_from_error(msg::AbstractString; attempted=Set{String}())
    missing = _missing_pkgs_from_error(msg)
    isempty(missing) && return false
    specs = Dict{String,String}[]
    repo_map = _registry_repo_map(_general_registry_path())
    for pkg in missing
        if pkg in attempted
            continue
        end
        if haskey(_url_fallbacks, pkg)
            push!(specs, _url_fallbacks[pkg])
            push!(attempted, pkg)
        elseif haskey(repo_map, pkg)
            push!(specs, Dict("url" => repo_map[pkg]))
            push!(attempted, pkg)
        end
    end
    isempty(specs) && return false
    _add_url_pkgs(specs; attempted=attempted)
    return true
end

const _url_fallbacks = Dict(
    "StatsBase"           => Dict("url" => "https://github.com/JuliaStats/StatsBase.jl", "rev" => "v0.34.6"),
    "GenericLinearAlgebra"=> Dict("url" => "https://github.com/JuliaLinearAlgebra/GenericLinearAlgebra.jl", "rev" => "v0.3.19"),
    "QuadGK"              => Dict("url" => "https://github.com/JuliaMath/QuadGK.jl", "rev" => "v2.10.1"),
    "Distributions"       => Dict("url" => "https://github.com/JuliaStats/Distributions.jl", "rev" => "v0.25.111"),
    "DataStructures"      => Dict("url" => "https://github.com/JuliaCollections/DataStructures.jl.git", "rev" => "v0.19.3"),
    "CSV"                 => Dict("url" => "https://github.com/JuliaData/CSV.jl.git", "rev" => "v0.10.15"),
    "PooledArrays"        => Dict("url" => "https://github.com/JuliaData/PooledArrays.jl.git", "rev" => "v1.4.3"),
    "FilePathsBase"       => Dict("url" => "https://github.com/rofinn/FilePathsBase.jl.git", "rev" => "v0.9.24"),
    "WorkerUtilities"     => Dict("url" => "https://github.com/JuliaServices/WorkerUtilities.jl.git", "rev" => "v1.6.0"),
    "Compat"              => Dict("url" => "https://github.com/JuliaLang/Compat.jl.git", "rev" => "v4.10.0"),
    "InlineStrings"       => Dict("url" => "https://github.com/JuliaData/InlineStrings.jl.git", "rev" => "v1.4.2"),
    "IOCapture"           => Dict("url" => "https://github.com/JuliaDocs/IOCapture.jl.git", "rev" => "v0.2.5"),
    "AngleBetweenVectors" => Dict("url" => "https://github.com/JeffreySarnoff/AngleBetweenVectors.jl.git"),
    "ToeplitzMatrices"    => Dict("url" => "https://github.com/JuliaLinearAlgebra/ToeplitzMatrices.jl.git", "rev" => "v0.8.5"),
    "AbstractFFTs"        => Dict("url" => "https://github.com/JuliaMath/AbstractFFTs.jl.git", "rev" => "v1.5.0"),
    "DSP"                 => Dict("url" => "https://github.com/JuliaDSP/DSP.jl.git", "rev" => "v0.8.4"),
    "Bessels"             => Dict("url" => "https://github.com/JuliaMath/Bessels.jl.git", "rev" => "v0.2.0"),
    "SIMDMath"            => Dict("url" => "https://github.com/JuliaSIMD/SIMDMath.jl.git", "rev" => "v0.2.5"),
    "FFTW"                => Dict("url" => "https://github.com/JuliaMath/FFTW.jl.git", "rev" => "v1.10.0"),
    "Hadamard"            => Dict("url" => "https://github.com/JuliaMath/Hadamard.jl.git", "rev" => "v1.8.0"),
    "MKL_jll"             => Dict("url" => "https://github.com/JuliaBinaryWrappers/MKL_jll.jl.git", "rev" => "MKL-v2024.0.0+0"),
)

try
    _refresh_registry()
catch
    _refresh_registry()
end

@info "Active registries"
Pkg.Registry.status()
general_path = nothing
try
    general_path = _general_registry_path()
    @info "Using General registry path" general_path
catch e
    @warn "General registry path not found; proceeding without registry path checks" exception=(e, catch_backtrace())
end

Pkg.instantiate()

registry_only_first = get(ENV, "JULIA_REGISTRY_ONLY_FIRST", "") in ("1", "true", "yes")

if !registry_only_first
    @info "Adding StatsBase from URL (pinned)"
    try
        _add_url_pkgs([Dict("url" => "https://github.com/JuliaStats/StatsBase.jl", "rev" => "v0.34.6")])
    catch
        # If this fails, continue; build will surface the error later.
    end
end

# Full package list (matches the manual install list).
all_pkgs = [
    "AbstractAlgebra",
    "BlockArrays",
    "SparseArrays",
    "LinearAlgebra",
    "Random",
    "RowEchelon",
    "Symbolics",
    "SymbolicUtils",
    "FFTW",
    "DSP",
    "ToeplitzMatrices",
    "Polynomials",
    "Hadamard",
    "Distributions",
    "StatsPlots",
    "CSV",
    "DataFrames",
    "RDatasets",
    "Plots",
    "PlotlyJS",
    "Colors",
    "GR",
    "Makie",
    "CairoMakie",
    "GLMakie",
    "WGLMakie",
    "Images",
    "ImageShow",
    "ImageView",
    "TestImages",
    "MosaicViews",
    "NearestNeighbors",
    "AngleBetweenVectors",
    "Interact",
    "WebIO",
    "Revise",
    "Latexify",
    "LaTeXStrings",
    "StyledStrings",
    "IJulia",
    "Pluto",
    "PythonCall",
]

safe_pkgs = Set([
    "AbstractAlgebra",
    "BlockArrays",
    "SparseArrays",
    "LinearAlgebra",
    "Random",
    "RowEchelon",
    "Symbolics",
    "SymbolicUtils",
    "FFTW",
    "DSP",
    "ToeplitzMatrices",
    "Polynomials",
    "Hadamard",
    "Distributions",
    "CSV",
    "DataFrames",
    "RDatasets",
    "Colors",
    "NearestNeighbors",
    "AngleBetweenVectors",
    "Revise",
    "Latexify",
    "LaTeXStrings",
    "StyledStrings",
])

@info "Adding requested packages (single Pkg.add call)"
attempted = Set{String}()
repo_map = general_path === nothing ? Dict{String,String}() : _registry_repo_map(general_path)
for _ in 1:3
    try
        _add_with_retry(all_pkgs; tries=1)
        break
    catch e
        msg = sprint(showerror, e)
        if _fallback_from_error(msg; attempted=attempted)
            continue
        end
        # Fallback for any packages missing registry entries.
        if general_path !== nothing
            missing = _missing_registry_pkgs(all_pkgs, general_path)
            for pkg in missing
                if haskey(_url_fallbacks, pkg)
                    _add_url_pkgs([_url_fallbacks[pkg]]; attempted=attempted)
                elseif haskey(repo_map, pkg)
                    _add_url_pkgs([Dict("url" => repo_map[pkg])]; attempted=attempted)
                else
                    @warn "No URL fallback available for $(pkg)"
                end
            end
        end
        # Try once more after fallbacks.
        _add_with_retry(all_pkgs; tries=1)
        break
    end
end

@info "Precompiling safe packages"
try
    Pkg.precompile()
catch e
    @warn "Precompile failed; continuing without strict precompile" exception=(e, catch_backtrace())
end
