using AbInitioSoftwareBase.Commands: Mpiexec, _expandargs
using CommandComposer: Option

import CommandComposer: Command

export PwX

struct PwX
    path::String
    env::Tuple
    options::NamedTuple{(:nimage, :npool, :ntg, :nyfft, :nband, :ndiag),NTuple{6,Int64}}
end
function PwX(path, env::Pair...; nimage=0, npool=0, ntg=0, nyfft=0, nband=0, ndiag=0)
    return PwX(
        path,
        Tuple(string(key) => string(value) for (key, value) in env),
        (nimage=nimage, npool=npool, ntg=ntg, nyfft=nyfft, nband=nband, ndiag=ndiag),
    )
end

function Command(pwx::PwX)
    options = map(pairs(pwx.options)) do (key, value)
        if !iszero(value)
            Option("", string(key), value)
        end
    end
    return Command(pwx.path, [], options, [], [])
end

function (mpiexec::Mpiexec)(pwx::PwX)
    if pwx.options[:ndiag]^2 > mpiexec.options[:np]
        @error "`ndiag` square should be less than `np`!"
    end
    args = _expandargs(mpiexec)
    pushfirst!(pwx.args, args...)
    return pwx
end

parentdir(file) = dirname(abspath(expanduser(file)))
