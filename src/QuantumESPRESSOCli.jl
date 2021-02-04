module QuantumESPRESSOCli

using AbInitioSoftwareBase: load
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw, ph, q2r, matdyn

@option "mpi" struct MpiexecOptions
    exe::String = "mpiexec"
    np::UInt = 0
    options::Dict{String,Any}
end

@option struct PwxOptions
    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

@option struct PwxConfig
    exe::String = "pw.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwxOptions = PwxOptions()
end

@option struct PhxConfig
    exe::String = "ph.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwxOptions = PwxOptions()
end

@option struct Q2rxConfig
    exe::String = "q2r.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwxOptions = PwxOptions()
end

@option struct MatdynxConfig
    exe::String = "matdyn.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwxOptions = PwxOptions()
end

@option struct QuantumESPRESSOCliConfig
    pw::PwxConfig = PwxConfig()
    ph::PhxConfig = PhxConfig()
    q2r::Q2rxConfig = Q2rxConfig()
    matdyn::MatdynxConfig = MatdynxConfig()
end

@cast function pw(input, output = tempname(; cleanup = false), error = ""; cfgfile = "")
    options = materialize(cfgfile).pw
    cmd = makecmd(input, output, error, options)
    return run(cmd)
end

@cast function ph(input, output = tempname(; cleanup = false), error = ""; cfgfile = "")
    options = materialize(cfgfile).ph
    cmd = makecmd(input, output, error, options)
    return run(cmd)
end

@cast function q2r(input, output = tempname(; cleanup = false), error = ""; cfgfile = "")
    options = materialize(cfgfile).q2r
    cmd = makecmd(input, output, error, options)
    return run(cmd)
end

@cast function matdyn(input, output = tempname(; cleanup = false), error = ""; cfgfile = "")
    options = materialize(cfgfile).matdyn
    cmd = makecmd(input, output, error, options)
    return run(cmd)
end

function materialize(cfgfile)
    options = if isfile(expanduser(cfgfile))
        dict = load(expanduser(cfgfile))
        from_dict(QuantumESPRESSOCliConfig, dict)
    else
        QuantumESPRESSOCliConfig()
    end
end

function makecmd(
    input,
    output = tempname(; cleanup = false),
    error = "",
    options::PwxConfig = PwxConfig(),
)
    args = [options.exe]
    for f in fieldnames(PwxOptions)
        v = getfield(options.options, f)
        if !iszero(v)
            push!(args, "-$f", string(v))
        end
    end
    dir = expanduser(dirname(input))
    if !isempty(options.script_dest)
        for (k, v) in zip(("-inp", "1>", "2>"), (input, output, error))
            if v !== nothing
                push!(args, k, "'$v'")
            end
        end
        if !isdir(dir)
            mkpath(dir)
        end
        str = join(args, " ")
        write(options.script_dest, str)
        chmod(options.script_dest, 0o755)
        return setenv(Cmd([abspath(options.script_dest)]); dir = dir)
    else
        push!(args, "-inp", "$input")
        return pipeline(setenv(Cmd(args); dir = dir), stdout = output, stderr = error)
    end
end
makecmd(input, output, error, options::AbstractDict) =
    makecmd(input, output, error, from_dict(Config, options))

"""
The main command `qe`.
"""
@main

end
