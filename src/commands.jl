using CommandComposer: ShortOption

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
    options = map(keys(pwx.options), values(pwx.options)) do key, value
        if !iszero(value)
            ShortOption(string(key), value)
        end
    end
    return Command(pwx.path, options, [], [])
end

parentdir(file) = dirname(abspath(expanduser(file)))
