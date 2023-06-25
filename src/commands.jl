using AbInitioSoftwareBase.Commands: Mpiexec

"""
    pw(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `pw.x`.
"""
function pw(input, output=mktemp(parentdir(input))[1]; kwargs...)
    return cmdtemplate(getpath("pw"), input, output; kwargs...)
end
"""
    ph(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `ph.x`.
"""
function ph(input, output=mktemp(parentdir(input))[1]; kwargs...)
    return cmdtemplate(getpath("ph"), input, output; kwargs...)
end
"""
    q2r(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `q2r.x`.
"""
function q2r(input, output=mktemp(parentdir(input))[1]; kwargs...)
    return cmdtemplate(getpath("q2r"), input, output; kwargs...)
end
"""
    matdyn(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `matdyn.x`.
"""
function matdyn(input, output=mktemp(parentdir(input))[1]; kwargs...)
    return cmdtemplate(getpath("matdyn"), input, output; kwargs...)
end
"""
    dynmat(input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for `dynmat.x`.
"""
function dynmat(input, output=mktemp(parentdir(input))[1]; kwargs...)
    return cmdtemplate(getpath("dynmat"), input, output; kwargs...)
end

"""
    cmdtemplate(path, input, output; chdir, nimage, npool, ntg, nyfft, nband, ndiag, np, env, kwargs...)

Make commands for QuantumESPRESSO executables.
"""
function cmdtemplate(
    path,
    input,
    output=mktemp(parentdir(input))[1];
    chdir=true,
    nimage=0,
    npool=0,
    ntg=0,
    nyfft=0,
    nband=0,
    ndiag=0,
    np=1,
    env=[],
    kwargs...,
)
    if ndiag^2 > np
        @error "`ndiag` square should be less than `np`!"
    end
    f = Mpiexec(env; np=np, kwargs...)
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
    return pipeline(Cmd(f(args); dir=dir); stdin=input, stdout=output)
end
