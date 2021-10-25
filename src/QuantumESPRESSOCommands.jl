module QuantumESPRESSOCommands

using AbInitioSoftwareBase: parentdir
using AbInitioSoftwareBase.Commands: mpiexec
@static if VERSION >= v"1.6"
    using Preferences: @load_preference, @set_preferences!
end

@static if VERSION >= v"1.6"
    function get_path(exe)
        if exe == "pw"
            return @load_preference("pw.x path", "pw.x")
        elseif exe == "ph"
            return @load_preference("ph.x path", "ph.x")
        elseif exe == "q2r"
            return @load_preference("q2r.x path", "q2r.x")
        elseif exe == "matdyn"
            return @load_preference("matdyn.x path", "matdyn.x")
        elseif exe == "dynmat"
            return @load_preference("dynmat.x path", "dynmat.x")
        else
            throw(ArgumentError("invalid option $exe."))
        end
    end
    function set_path(exe, path::String)
        @assert ispath(path)
        if exe == "pw"
            @set_preferences!("pw.x path" => path)
        elseif exe == "ph"
            @set_preferences!("ph.x path" => path)
        elseif exe == "q2r"
            @set_preferences!("q2r.x path" => path)
        elseif exe == "matdyn"
            @set_preferences!("matdyn.x path" => path)
        elseif exe == "dynmat"
            @set_preferences!("dynmat.x path" => path)
        else
            throw(ArgumentError("invalid option $exe."))
        end
    end
else
    function get_path(exe)
        if exe == "pw"
            return "pw.x"
        elseif exe == "ph"
            return "ph.x"
        elseif exe == "q2r"
            return "q2r.x"
        elseif exe == "matdyn"
            return "matdyn.x"
        elseif exe == "dynmat"
            return "dynmat.x"
        else
            throw(ArgumentError("invalid option $exe."))
        end
    end
end

export pw, ph, q2r, matdyn, dynmat

"""
    pw(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `pw.x`.
"""
pw(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("pw"), input, output; kwargs...)
"""
    ph(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `ph.x`.
"""
ph(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("ph"), input, output; kwargs...)
"""
    q2r(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `q2r.x`.
"""
q2r(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("q2r"), input, output; kwargs...)
"""
    matdyn(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `matdyn.x`.
"""
matdyn(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("matdyn"), input, output; kwargs...)
"""
    dynmat(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `dynmat.x`.
"""
dynmat(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("dynmat"), input, output; kwargs...)

"""
    cmdtemplate(path, input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for QuantumESPRESSO executables.
"""
function cmdtemplate(
    path,
    input,
    output = mktemp(parentdir(input))[1];
    chdir = true,
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
    np = 1,
    env = [],
    kwargs...,
)
    if ndiag^2 > np
        @error "`ndiag` square should be less than `np`!"
    end
    f = mpiexec(env; np = np, kwargs...)
    args = [path]
    for (key, value) in zip(
        (:nimage, :npool, :ntg, :nyfft, :nband, :ndiag),
        (nimage, npool, ntg, nyfft, nband, ndiag),
    )
        if !iszero(value)
            push!(args, "-$key", string(value))
        end
    end
    dir = abspath(chdir ? parentdir(input) : pwd())
    return pipeline(Cmd(f(args); dir = dir); stdin = input, stdout = output)
end

end
