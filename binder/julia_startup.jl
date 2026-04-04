ENV["LANG"] = "en_US.UTF-8"
ENV["LC_ALL"] = "en_US.UTF-8"

const _lalatex_pythoncall_bridge_installed = Ref(false)

function _install_lalatex_pythoncall_bridge()
    _lalatex_pythoncall_bridge_installed[] && return
    if !(isdefined(Main, :LAlatex) && isdefined(Main, :PythonCall))
        return
    end

    @eval Main begin
        import LAlatex
        import PythonCall

        function LAlatex.L_show_core(obj::PythonCall.Py; kwargs...)
            converted = try
                PythonCall.pyconvert(Any, obj)
            catch
                obj
            end

            if converted isa PythonCall.Py
                converted = try
                    collect(obj)
                catch
                    obj
                end
            end

            converted isa PythonCall.Py && error("Unsupported argument type: PythonCall.Py")
            return LAlatex.L_show_core(converted; kwargs...)
        end
    end

    _lalatex_pythoncall_bridge_installed[] = true
end

try
    push!(Base.package_callbacks) do _
        try
            _install_lalatex_pythoncall_bridge()
        catch
        end
    end
catch
end

try
    _install_lalatex_pythoncall_bridge()
catch
end
