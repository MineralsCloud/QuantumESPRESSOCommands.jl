module QuantumESPRESSOCommands

using AbInitioSoftwareBase: parentdir
using AbInitioSoftwareBase.Commands: CommandConfig, MpiexecConfig
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw, ph, q2r, matdyn, dynmat

"""
    ParallelizationFlags(; nimage=0, npool=0, ntg=0, nyfft=0, nband=0, ndiag=0)

Construct parallelization flags of QuantumESPRESSO commands.
"""
@option struct ParallelizationFlags
    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

"""
    PwxConfig(; exe, chdir, options)

Create configurations for `pw.x`.

# Arguments
- `exe::String="pw.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `pw.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `pw.x`.
"""
@option struct PwxConfig <: CommandConfig
    exe::String = "pw.x"
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    PhxConfig(; exe, chdir, options)

Create configurations for `ph.x`.

# Arguments
- `exe::String="ph.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `ph.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `ph.x`.
"""
@option struct PhxConfig <: CommandConfig
    exe::String = "ph.x"
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    Q2rxConfig(; exe, chdir, options)

Create configurations for `q2r.x`.

# Arguments
- `exe::String="q2r.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `q2r.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `q2r.x`.
"""
@option struct Q2rxConfig <: CommandConfig
    exe::String = "q2r.x"
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    MatdynxConfig(; exe, chdir, options)

Create configurations for `matdyn.x`.

# Arguments
- `exe::String="matdyn.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `matdyn.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `matdyn.x`.
"""
@option struct MatdynxConfig <: CommandConfig
    exe::String = "matdyn.x"
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    DynmatxConfig(; exe, chdir, options)

Create configurations for `dynmat.x`.

# Arguments
- `exe::String="dynmat.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `dynmat.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `dynmat.x`.
"""
@option struct DynmatxConfig <: CommandConfig
    exe::String = "dynmat.x"
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end

@option struct QuantumESPRESSOConfig <: CommandConfig
    mpi::MpiexecConfig = MpiexecConfig()
    pw::PwxConfig = PwxConfig()
    ph::PhxConfig = PhxConfig()
    q2r::Q2rxConfig = Q2rxConfig()
    matdyn::MatdynxConfig = MatdynxConfig()
    dynmat::DynmatxConfig = DynmatxConfig()
end

"""
    pw(input, output, error; use_script, mpi, main, cfgfile)

Run command `pw.x`.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under the directory where the input file is stored, and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main=PwxConfig()`: the configurations of the main executable. In this case,
  `pw.x`.
- `cfgfile=""`: if not empty, load these configurations from a file.
"""
@cast function pw(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    exe = "pw.x",
    chdir = true,
    use_script = false,
)
    mpi = MpiexecConfig(; np = np)
    main = PwxConfig(; exe = exe, chdir = chdir, use_script = use_script)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = main.chdir ? parentdir(input) : pwd(),  # See https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/pull/10
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end
"""
    ph(input, output, error; use_script, mpi, main, cfgfile)

Run command `ph.x`.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under the directory where the input file is stored, and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main=PhxConfig()`: the configurations of the main executable. In this case,
  `ph.x`.
- `cfgfile=""`: if not empty, load these configurations from a file.
"""
@cast function ph(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    exe = "ph.x",
    chdir = true,
    use_script = false,
)
    mpi = MpiexecConfig(; np = np)
    main = PhxConfig(; exe = exe, chdir = chdir, use_script = use_script)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = main.chdir ? parentdir(input) : pwd(),  # See https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/pull/10
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end
"""
    q2r(input, output, error; use_script, mpi, main, cfgfile)

Run command `q2r.x`.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under the directory where the input file is stored, and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main=Q2rxConfig()`: the configurations of the main executable. In this case,
  `q2r.x`.
- `cfgfile=""`: if not empty, load these configurations from a file.
"""
@cast function q2r(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    exe = "q2r.x",
    chdir = true,
    use_script = false,
)
    mpi = MpiexecConfig(; np = np)
    main = Q2rxConfig(; exe = exe, chdir = chdir, use_script = use_script)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = main.chdir ? parentdir(input) : pwd(),  # See https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/pull/10
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end
"""
    matdyn(input, output, error; use_script, mpi, main, cfgfile)

Run command `matdyn.x`.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under the directory where the input file is stored, and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main=MatdynxConfig()`: the configurations of the main executable. In this
  case, `matdyn.x`.
- `cfgfile=""`: if not empty, load these configurations from a file.
"""
@cast function matdyn(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    exe = "matdyn.x",
    chdir = true,
    use_script = false,
)
    mpi = MpiexecConfig(; np = np)
    main = MatdynxConfig(; exe = exe, chdir = chdir, use_script = use_script)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = main.chdir ? parentdir(input) : pwd(),  # See https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/pull/10
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end
"""
    dynmat(input, output, error; use_script, mpi, main, cfgfile)

Run command `dynmat.x`.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under the directory where the input file is stored, and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main=DynmatxConfig()`: the configurations of the main executable. In this
  case, `dynmat.x`.
- `cfgfile=""`: if not empty, load these configurations from a file.
"""
@cast function dynmat(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    exe = "dynmat.x",
    chdir = true,
    use_script = false,
)
    mpi = MpiexecConfig(; np = np)
    main = DynmatxConfig(; exe = exe, chdir = chdir, use_script = use_script)
    cmd = makecmd(
        input;
        output = output,
        error = error,
        dir = main.chdir ? parentdir(input) : pwd(),  # See https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/pull/10
        mpi = mpi,
        main = main,
    )
    return run(cmd)
end

"""
    makecmd(input; output, error, dir, use_script, mpi, main)

Make commands for QuantumESPRESSO executables.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `dir=parentdir(input)`: change the working directory to `dir`. By default, it
  is the directory where the input file is stored.
- `use_script=false`: if `true`, generate a shell script (with a random name)
  under `dir` and run it.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main`: the configurations of the main executable.
"""
function makecmd(
    input;
    output = mktemp(parentdir(input))[1],
    error = output,
    dir = parentdir(input),
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
    if main.use_script
        for (k, v) in zip(("-inp", "1>", "2>"), (input, output, error))
            if v !== nothing
                push!(args, k, "'$v'")
            end
        end
        str = join(args, " ")
        if !isdir(dir)
            mkpath(dir)
        end
        script, io = mktemp(dir)
        write(io, str)
        close(io)
        chmod(script, 0o755)
        return setenv(Cmd([abspath(script)]), ENV; dir = abspath(dir))
    else
        push!(args, "-inp", "$input")
        return pipeline(
            setenv(Cmd(args), ENV; dir = abspath(dir)),
            stdout = output,
            stderr = error,
        )
    end
end

"""
The main command `qe`.
"""
@main

end
