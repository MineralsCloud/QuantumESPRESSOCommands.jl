module QuantumESPRESSOCommands

using AbInitioSoftwareBase: parentdir
using AbInitioSoftwareBase.Commands: CommandConfig, MpiexecConfig, mpiexec
using Comonicon: @cast, @main
using Configurations: from_dict, @option
using QuantumEspresso_jll

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
    PwxConfig(; exe, chdir, use_script, options)

Create configurations for `pw.x`.

# Arguments
- `exe::String="pw.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `pw.x`. If `false`, stay in the current directory.
- `use_script=false`: if `true`, generate a shell script (with a random name) and run it.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `pw.x`.
"""
@option struct PwxConfig <: CommandConfig
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    PhxConfig(; exe, chdir, use_script, options)

Create configurations for `ph.x`.

# Arguments
- `exe::String="ph.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `ph.x`. If `false`, stay in the current directory.
- `use_script=false`: if `true`, generate a shell script (with a random name) and run it.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `ph.x`.
"""
@option struct PhxConfig <: CommandConfig
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    Q2rxConfig(; exe, chdir, use_script, options)

Create configurations for `q2r.x`.

# Arguments
- `exe::String="q2r.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `q2r.x`. If `false`, stay in the current directory.
- `use_script=false`: if `true`, generate a shell script (with a random name) and run it.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `q2r.x`.
"""
@option struct Q2rxConfig <: CommandConfig
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    MatdynxConfig(; exe, chdir, use_script, options)

Create configurations for `matdyn.x`.

# Arguments
- `exe::String="matdyn.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `matdyn.x`. If `false`, stay in the current directory.
- `use_script=false`: if `true`, generate a shell script (with a random name) and run it.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `matdyn.x`.
"""
@option struct MatdynxConfig <: CommandConfig
    chdir::Bool = true
    use_script::Bool = false
    options::ParallelizationFlags = ParallelizationFlags()
end
"""
    DynmatxConfig(; exe, chdir, use_script, options)

Create configurations for `dynmat.x`.

# Arguments
- `exe::String="dynmat.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `dynmat.x`. If `false`, stay in the current directory.
- `use_script=false`: if `true`, generate a shell script (with a random name) and run it.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `dynmat.x`.
"""
@option struct DynmatxConfig <: CommandConfig
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
Run command `pw.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.
- `error`: the path to the error file. By default, it is the output file.

# Options

- `--np <n>`: the number of processes used. If zero, no parallelization is performed.
- `--exe <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
- `--use-script`: if true, generate a temporary shell script under the directory where the
  input file is stored, and run it.
"""
@cast function pw(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
    chdir = false,
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
Run command `ph.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.
- `error`: the path to the error file. By default, it is the output file.

# Options

- `--np <n>`: the number of processes used. If zero, no parallelization is performed.
- `--exe <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
- `--use-script`: if true, generate a temporary shell script under the directory where the
  input file is stored, and run it.
"""
@cast function ph(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
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
Run command `q2r.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.
- `error`: the path to the error file. By default, it is the output file.

# Options

- `--np <n>`: the number of processes used. If zero, no parallelization is performed.
- `--exe <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
- `--use-script`: if true, generate a temporary shell script under the directory where the
  input file is stored, and run it.
"""
@cast function q2r(
    input,
    output = mktemp(parentdir(input))[1],
    error = output;
    np = 0,
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
Run command `matdyn.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.
- `error`: the path to the error file. By default, it is the output file.

# Options

- `--np <n>`: the number of processes used. If zero, no parallelization is performed.
- `--exe <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
- `--use-script`: if true, generate a temporary shell script under the directory where the
  input file is stored, and run it.
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
Run command `dynmat.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.
- `error`: the path to the error file. By default, it is the output file.

# Options

- `--np <n>`: the number of processes used. If zero, no parallelization is performed.
- `--exe <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
- `--use-script`: if true, generate a temporary shell script under the directory where the
  input file is stored, and run it.
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
    makecmd(input; output, error, dir, mpi, main)

Make commands for QuantumESPRESSO executables.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `error=output`: the path to the error file. By default, it logs into the
  output file.
- `dir=parentdir(input)`: change the working directory to `dir`. By default, it
  is the directory where the input file is stored.
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
    f = mpiexec(mpi)
    args = [main.exec]
    for f in fieldnames(ParallelizationFlags)
        v = getfield(main.options, f)
        if !iszero(v)
            push!(args, "-$f", string(v))
        end
    end
    if main.use_script
        # for (k, v) in zip(("-inp", "1>", "2>"), (input, output, error))
        #     if v !== nothing
        #         push!(args, k, "'$v'")
        #     end
        # end
        # str = join(args, " ")
        # if !isdir(dir)
        #     mkpath(dir)
        # end
        # script, io = mktemp(dir)
        # write(io, str)
        # close(io)
        # chmod(script, 0o755)
        # return setenv(Cmd([abspath(script)]), ENV; dir = abspath(dir))
    else
        push!(args, "-inp", "$input")
        return pipeline(f(args; env = main.env); stdout = output, stderr = error)
    end
end

"""
The main command `qe`.
"""
@main

end
