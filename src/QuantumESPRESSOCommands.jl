module QuantumESPRESSOCommands

using AbInitioSoftwareBase: parentdir
using AbInitioSoftwareBase.Commands: CommandConfig, mpiexec
using Comonicon: @cast, @main
using Configurations: from_dict, @option
@static if VERSION >= v"1.6"
    using Preferences: @load_preference
end

@static if VERSION >= v"1.6"
    const pw_path = @load_preference("pw.x path", "pw.x")
    const ph_path = @load_preference("ph.x path", "ph.x")
    const q2r_path = @load_preference("q2r.x path", "q2r.x")
    const matdyn_path = @load_preference("matdyn.x path", "matdyn.x")
    const dynmat_path = @load_preference("dynmat.x path", "dynmat.x")
else
    const pw_path = "pw.x"
    const ph_path = "ph.x"
    const q2r_path = "q2r.x"
    const matdyn_path = "matdyn.x"
    const dynmat_path = "dynmat.x"
end

export pw, ph, q2r, matdyn, dynmat

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
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
)
    mpi = MpiexecConfig(; np = np)
    main = PwxConfig(;
        path = path,
        chdir = chdir,
        nimage = nimage,
        npool = npool,
        ntg = ntg,
        nyfft = nyfft,
        nband = nband,
        ndiag = ndiag,
    )
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
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
)
    mpi = MpiexecConfig(; np = np)
    main = PhxConfig(;
        path = path,
        chdir = chdir,
        nimage = nimage,
        npool = npool,
        ntg = ntg,
        nyfft = nyfft,
        nband = nband,
        ndiag = ndiag,
    )
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
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
)
    mpi = MpiexecConfig(; np = np)
    main = Q2rxConfig(;
        path = path,
        chdir = chdir,
        nimage = nimage,
        npool = npool,
        ntg = ntg,
        nyfft = nyfft,
        nband = nband,
        ndiag = ndiag,
    )
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
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
)
    mpi = MpiexecConfig(; np = np)
    main = MatdynxConfig(;
        path = path,
        chdir = chdir,
        nimage = nimage,
        npool = npool,
        ntg = ntg,
        nyfft = nyfft,
        nband = nband,
        ndiag = ndiag,
    )
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
    nimage = 0,
    npool = 0,
    ntg = 0,
    nyfft = 0,
    nband = 0,
    ndiag = 0,
)
    mpi = MpiexecConfig(; np = np)
    main = DynmatxConfig(;
        path = path,
        chdir = chdir,
        nimage = nimage,
        npool = npool,
        ntg = ntg,
        nyfft = nyfft,
        nband = nband,
        ndiag = ndiag,
    )
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
    kwargs...,
)
    if ndiag^2 > np
        @error "`ndiag` square should be less than `np`!"
    end
    f = mpiexec(; kwargs...)
    args = [path]
    for (key, value) in (;
        zip(
            (:nimage, :npool, :ntg, :nyfft, :nband, :ndiag),
            (nimage, npool, ntg, nyfft, nband, ndiag),
        )...,
    )
        if !iszero(value)
            push!(args, "-$key", string(value))
        end
    end
    dir = abspath(chdir ? parentdir(input) : pwd())
    return pipeline(Cmd(f(args); dir = dir); stdin = input, stdout = output)
end

"""
The main command `qe`.
"""
@main

end
