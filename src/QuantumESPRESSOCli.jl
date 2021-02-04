module QuantumESPRESSOCli

using AbInitioSoftwareBase
using Comonicon: @cast, @main
using Configurations: from_dict, @option

export pw

@option struct PwXConfig
@option "mpi" struct MpiexecOptions
    exe::String = "mpiexec"
    np::UInt = 0
    options::Dict{String,Any}
end

    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

@option struct PwConfig
    exe::String = "pw.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwXConfig = PwXConfig()
end

@cast function pw(input, output = tempname(; cleanup = false), error = ""; config = "")
    options = if isfile(expanduser(config))
        dict = load(expanduser(config))
        from_dict(PwConfig, dict)
    else
        PwConfig()
    end
    cmd = makecmd(input, output, error, options)
    return run(cmd)
end

function makecmd(
    input,
    output = tempname(; cleanup = false),
    error = "",
    options::PwConfig = PwConfig(),
)
    args = [options.exe]
    for f in fieldnames(PwXConfig)
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
    makecmd(input, output, error, from_dict(PwConfig, options))

"""
The main command `qe`.
"""
@main

end
