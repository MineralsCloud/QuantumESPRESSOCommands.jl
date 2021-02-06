module QuantumESPRESSOCli

using AbInitioSoftwareBase: load
using AbInitioSoftwareBase.Cli: MpiexecOptions
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw, ph, q2r, matdyn

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
    mpi::MpiexecOptions = MpiexecOptions()
    pw::PwxConfig = PwxConfig()
    ph::PhxConfig = PhxConfig()
    q2r::Q2rxConfig = Q2rxConfig()
    matdyn::MatdynxConfig = MatdynxConfig()
end

@cast function pw(input, output = tempname(; cleanup = false), error = output; cfgfile = "")
    config = materialize(cfgfile)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        mpi = config.mpi,
        options = config.pw,
    )
    return run(cmd)
end

@cast function ph(input, output = tempname(; cleanup = false), error = output; cfgfile = "")
    config = materialize(cfgfile)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        mpi = config.mpi,
        options = config.ph,
    )
    return run(cmd)
end

@cast function q2r(
    input,
    output = tempname(; cleanup = false),
    error = output;
    cfgfile = "",
)
    config = materialize(cfgfile)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        mpi = config.mpi,
        options = config.q2r,
    )
    return run(cmd)
end

@cast function matdyn(
    input,
    output = tempname(; cleanup = false),
    error = output;
    cfgfile = "",
)
    config = materialize(cfgfile)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        mpi = config.mpi,
        options = config.matdyn,
    )
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
    input;
    output = tempname(; cleanup = false),
    error = "",
    mpi = MpiexecOptions(),
    options = PwxConfig(),
)
    if mpi.np == 0
        args = [options.exe]
    else
        args = [mpi.exe, string(mpi.np)]
        for (k, v) in mpi.options
            push!(args, k, string(v))
        end
    end
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

"""
The main command `qe`.
"""
@main

end
