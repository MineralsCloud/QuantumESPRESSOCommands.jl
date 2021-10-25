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
pw(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("pw"), input, output; kwargs...)
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
ph(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("ph"), input, output; kwargs...)
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
q2r(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("q2r"), input, output; kwargs...)
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
matdyn(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("matdyn"), input, output; kwargs...)
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
dynmat(input, output = mktemp(parentdir(input))[1]; kwargs...) =
    cmdtemplate(get_path("dynmat"), input, output; kwargs...)

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
