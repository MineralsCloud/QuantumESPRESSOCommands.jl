using AbInitioSoftwareBase.Commands: Executable, ExecutableChain, Mpiexec
using ComposableCommands: ShortOption

import ComposableCommands: Command

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
function Command(chain::ExecutableChain{Mpiexec,PwX})
    cmd = Command(chain.a)
    push!(cmd.subcommands, Command(chain.b))
    return cmd
end

parentdir(file) = dirname(abspath(expanduser(file)))
