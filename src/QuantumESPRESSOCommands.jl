module QuantumESPRESSOCommands

using AbInitioSoftwareBase: load
using AbInitioSoftwareBase.Commands: CommandConfig, MpiexecConfig
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw, ph, q2r, matdyn, dynmat

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

@option struct DynmatxConfig <: CommandConfig
    exe::String = "dynmat.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct QuantumESPRESSOCliConfig <: CommandConfig
    mpi::MpiexecConfig = MpiexecConfig()
    pw::PwxConfig = PwxConfig()
    ph::PhxConfig = PhxConfig()
    q2r::Q2rxConfig = Q2rxConfig()
    matdyn::MatdynxConfig = MatdynxConfig()
    dynmat::DynmatxConfig = DynmatxConfig()
end

@cast function pw(
    input,
    output = tempname(parentdir(input)),
    error = output;
    use_script = false,
    mpi = MpiexecConfig(),
    main = PwxConfig(),
    cfgfile = "",
)
    if !isempty(cfgfile)
        config = readconfig(cfgfile)
        mpi, main = config.mpi, config.pw
    end
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = parentdir(input),
        use_script = use_script,
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end

@cast function ph(
    input,
    output = tempname(parentdir(input)),
    error = output;
    use_script = false,
    mpi = MpiexecConfig(),
    main = PwxConfig(),
    cfgfile = "",
)
    if !isempty(cfgfile)
        config = readconfig(cfgfile)
        mpi, main = config.mpi, config.ph
    end
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = parentdir(input),
        use_script = use_script,
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end

@cast function q2r(
    input,
    output = tempname(parentdir(input)),
    error = output;
    use_script = false,
    mpi = MpiexecConfig(),
    main = PwxConfig(),
    cfgfile = "",
)
    if !isempty(cfgfile)
        config = readconfig(cfgfile)
        mpi, main = config.mpi, config.q2r
    end
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = parentdir(input),
        use_script = use_script,
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end

@cast function matdyn(
    input,
    output = tempname(parentdir(input)),
    error = output;
    use_script = false,
    mpi = MpiexecConfig(),
    main = PwxConfig(),
    cfgfile = "",
)
    if !isempty(cfgfile)
        config = readconfig(cfgfile)
        mpi, main = config.mpi, config.matdyn
    end
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = parentdir(input),
        use_script = use_script,
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end

@cast function dynmat(
    input,
    output = tempname(parentdir(input)),
    error = output;
    use_script = false,
    mpi = MpiexecConfig(),
    main = PwxConfig(),
    cfgfile = "",
)
    if !isempty(cfgfile)
        config = readconfig(cfgfile)
        mpi, main = config.mpi, config.dynmat
    end
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = parentdir(input),
        use_script = use_script,
        mpi = mpi,
        main = main,
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
    output = tempname(parentdir(input)),
    error = output,
    dir = parentdir(input),
    use_script = false,
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
    if !use_script
        for (k, v) in zip(("-inp", "1>", "2>"), (input, output, error))
            if v !== nothing
                push!(args, k, "'$v'")
            end
        end
        if !isdir(dir)
            mkpath(dir)
        end
        str = join(args, " ")
        script = tempname(dir)
        write(script, str)
        chmod(script, 0o755)
        return setenv(Cmd([abspath(script)]), ENV; dir = dir)
    else
        push!(args, "-inp", "$input")
        return pipeline(setenv(Cmd(args), ENV; dir = dir), stdout = output, stderr = error)
    end
end

function parentdir(file)
    dir = dirname(expanduser(file))
    if isempty(dir)
        dir = pwd()
    end
    return abspath(dir)
end

"""
The main command `qe`.
"""
@main

end
