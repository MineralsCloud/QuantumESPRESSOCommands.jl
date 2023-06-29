using AbInitioSoftwareBase.Commands: Executable, ExecutableChain, Mpiexec
using CommandComposer: ShortOption

import CommandComposer: Command

export PwX

struct PwX <: Executable
    path::String
    env::Tuple
    options::Iterators.Pairs
end
PwX(path, env::Pair...; options...) =
    PwX(path, Tuple(string(key) => string(value) for (key, value) in env), options)

function Command(pwx::PwX)
    options = map(keys(pwx.options), values(pwx.options)) do key, value
        if !iszero(value)
            ShortOption(string(key), value)
        end
    end
    return Command(pwx.path, options, [], [])
end

parentdir(file) = dirname(abspath(expanduser(file)))
