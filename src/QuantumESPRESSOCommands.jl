module QuantumESPRESSOCommands

using AbInitioSoftwareBase: load
using AbInitioSoftwareBase.Commands: CommandConfig, MpiexecConfig
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw, ph, q2r, matdyn

@option struct ParallelizationFlags
    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

@option struct PwxConfig <: CommandConfig
    exe::String = "pw.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct PhxConfig <: CommandConfig
    exe::String = "ph.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct Q2rxConfig <: CommandConfig
    exe::String = "q2r.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct MatdynxConfig <: CommandConfig
    exe::String = "matdyn.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct QuantumESPRESSOCliConfig <: CommandConfig
    mpi::MpiexecConfig = MpiexecConfig()
    pw::PwxConfig = PwxConfig()
    ph::PhxConfig = PhxConfig()
    q2r::Q2rxConfig = Q2rxConfig()
    matdyn::MatdynxConfig = MatdynxConfig()
end

@cast function pw(input, output = tempname(; cleanup = false), error = output; cfgfile = "")
    config = readconfig(cfgfile)
    cmd = makecmd(input; output = output, error = error, mpi = config.mpi, main = config.pw)
    return run(cmd)
end

@cast function ph(input, output = tempname(; cleanup = false), error = output; cfgfile = "")
    config = readconfig(cfgfile)
    cmd = makecmd(input; output = output, error = error, mpi = config.mpi, main = config.ph)
    return run(cmd)
end

@cast function q2r(
    input,
    output = tempname(; cleanup = false),
    error = output;
    cfgfile = "",
)
    config = readconfig(cfgfile)
    cmd =
        makecmd(input; output = output, error = error, mpi = config.mpi, main = config.q2r)
    return run(cmd)
end

@cast function matdyn(
    input,
    output = tempname(; cleanup = false),
    error = output;
    cfgfile = "",
)
    config = readconfig(cfgfile)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        mpi = config.mpi,
        main = config.matdyn,
    )
    return run(cmd)
end

function readconfig(cfgfile)
    cfgfile = expanduser(cfgfile)
    return if isfile(cfgfile)
        dict = load(cfgfile)
        from_dict(QuantumESPRESSOCliConfig, dict)
    else
        @warn "file $cfgfile not found! We will use default options!"
        QuantumESPRESSOCliConfig()
    end
end

function makecmd(
    input;
    output = tempname(; cleanup = false),
    error = "",
    as_script = "",
    mpi = MpiexecConfig(),
    main,
)
    if mpi.np == 0
        args = [main.exe]
    else
        args = [mpi.exe, "-n", string(mpi.np)]
        for (k, v) in mpi.options
            push!(args, k, string(v))
        end
        push!(args, main.exe)
    end
    for f in fieldnames(ParallelizationFlags)
        v = getfield(main.options, f)
        if !iszero(v)
            push!(args, "-$f", string(v))
        end
    end
    dir = expanduser(dirname(input))
    if !isempty(as_script)
        for (k, v) in zip(("-inp", "1>", "2>"), (input, output, error))
            if v !== nothing
                push!(args, k, "'$v'")
            end
        end
        if !isdir(dir)
            mkpath(dir)
        end
        str = join(args, " ")
        write(as_script, str)
        chmod(as_script, 0o755)
        return setenv(Cmd([abspath(as_script)]), ENV; dir = dir)
    else
        push!(args, "-inp", "$input")
        return pipeline(setenv(Cmd(args), ENV; dir = dir), stdout = output, stderr = error)
    end
end

"""
The main command `qe`.
"""
@main

end
