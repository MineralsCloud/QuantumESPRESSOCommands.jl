module QuantumESPRESSOCommands

using AbInitioSoftwareBase: parentdir
using AbInitioSoftwareBase.Commands: CommandConfig, MpiexecConfig, mpiexec
using Comonicon: @cast, @main
using Compat: addenv
using Configurations: from_dict, @option
using QuantumEspresso_jll:
    pwscf, phonon, reciprocal_to_real, dynamical_matrix_gamma, dynamical_matrix_generic

export pw, ph, q2r, matdyn, dynmat

"""
    ParallelizationFlags(; nimage=0, npool=0, ntg=0, nyfft=0, nband=0, ndiag=0)

Construct parallelization flags of QuantumESPRESSO commands.
"""
@option mutable struct ParallelizationFlags
    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

"""
    PwxConfig(; path, chdir, options)

Create configurations for `pw.x`.

# Arguments
- `path::String="pw.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `pw.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `pw.x`.
"""
@option mutable struct PwxConfig <: CommandConfig
    path::String = "pw.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
    env::Union{Dict,Vector} = Dict(ENV)
end
"""
    PhxConfig(; path, chdir, options)

Create configurations for `ph.x`.

# Arguments
- `path::String="ph.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `ph.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `ph.x`.
"""
@option mutable struct PhxConfig <: CommandConfig
    path::String = "ph.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
    env::Union{Dict,Vector} = Dict(ENV)
end
"""
    Q2rxConfig(; path, chdir, options)

Create configurations for `q2r.x`.

# Arguments
- `path::String="q2r.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `q2r.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `q2r.x`.
"""
@option mutable struct Q2rxConfig <: CommandConfig
    path::String = "q2r.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
    env::Union{Dict,Vector} = Dict(ENV)
end
"""
    MatdynxConfig(; path, chdir, options)

Create configurations for `matdyn.x`.

# Arguments
- `path::String="matdyn.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `matdyn.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `matdyn.x`.
"""
@option mutable struct MatdynxConfig <: CommandConfig
    path::String = "matdyn.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
    env::Union{Dict,Vector} = Dict(ENV)
end
"""
    DynmatxConfig(; path, chdir, options)

Create configurations for `dynmat.x`.

# Arguments
- `path::String="dynmat.x"`: the path to the executable.
- `chdir::Bool=true`: whether to change directory to where the input file is
  stored when running `dynmat.x`. If `false`, stay in the current directory.
- `options::ParallelizationFlags=ParallelizationFlags()`: the parallelization
  flags of `dynmat.x`.
"""
@option mutable struct DynmatxConfig <: CommandConfig
    path::String = "dynmat.x"
    chdir::Bool = true
    options::ParallelizationFlags = ParallelizationFlags()
    env::Union{Dict,Vector} = Dict(ENV)
end

@option mutable struct QuantumESPRESSOConfig <: CommandConfig
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

# Options

- `--np <n>`: the number of processes used.
- `--path <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
"""
@cast function pw(
    input,
    output = mktemp(parentdir(input))[1];
    np = 1,
    path = "pw.x",
    chdir = false,
)
    mpi = MpiexecConfig(; np = np)
    main = PwxConfig(; path = path, chdir = chdir)
    cmd = makecmd(input, output; mpi = mpi, main = main)
    return run(cmd)
end
"""
Run command `ph.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.

# Options

- `--np <n>`: the number of processes used.
- `--path <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
"""
@cast function ph(
    input,
    output = mktemp(parentdir(input))[1];
    np = 1,
    path = "ph.x",
    chdir = true,
)
    mpi = MpiexecConfig(; np = np)
    main = PhxConfig(; path = path, chdir = chdir)
    cmd = makecmd(input, output; mpi = mpi, main = main)
    return run(cmd)
end
"""
Run command `q2r.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.

# Options

- `--np <n>`: the number of processes used.
- `--path <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
"""
@cast function q2r(
    input,
    output = mktemp(parentdir(input))[1];
    np = 1,
    path = "q2r.x",
    chdir = true,
)
    mpi = MpiexecConfig(; np = np)
    main = Q2rxConfig(; path = path, chdir = chdir)
    cmd = makecmd(input, output; mpi = mpi, main = main)
    return run(cmd)
end
"""
Run command `matdyn.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.

# Options

- `--np <n>`: the number of processes used.
- `--path <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
"""
@cast function matdyn(
    input,
    output = mktemp(parentdir(input))[1];
    np = 1,
    path = "matdyn.x",
    chdir = true,
)
    mpi = MpiexecConfig(; np = np)
    main = MatdynxConfig(; path = path, chdir = chdir)
    cmd = makecmd(input, output; mpi = mpi, main = main)
    return run(cmd)
end
"""
Run command `dynmat.x`.

# Arguments

- `input`: the path to the input file.
- `output`: the path to the output file. If not specified, use a temporary path.

# Options

- `--np <n>`: the number of processes used.
- `--path <path>`: the path to the executable.

# Flags

- `--chdir`: if true, change directory to where the input file is stored when running.
"""
@cast function dynmat(
    input,
    output = mktemp(parentdir(input))[1];
    np = 1,
    path = "dynmat.x",
    chdir = true,
)
    mpi = MpiexecConfig(; np = np)
    main = DynmatxConfig(; path = path, chdir = chdir)
    cmd = makecmd(input, output; mpi = mpi, main = main)
    return run(cmd)
end

"""
    makecmd(input, output; dir, mpi, main)

Make commands for QuantumESPRESSO executables.

# Arguments
- `input`: the path to the input file.
- `output=mktemp(parentdir(input))[1]`: the path to the output file.
- `mpi=MpiexecConfig()`: MPI configurations.
- `main`: the configurations of the main executable.
"""
function makecmd(input, output = mktemp(parentdir(input))[1]; mpi = MpiexecConfig(), main)
    f = mpiexec(mpi)
    args = [main.path]
    for name in fieldnames(ParallelizationFlags)
        value = getfield(main.options, name)
        if !iszero(value)
            push!(args, "-$name", string(value))
        end
    end
    dir = abspath(main.chdir ? parentdir(input) : pwd())
    return pipeline(
        Cmd(addenv(f(args), main.env); dir = dir);
        stdin = input,
        stdout = output,
    )
end

"""
The main command `qe`.
"""
@main

end
