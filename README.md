# QuantumESPRESSOCommands

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://MineralsCloud.github.io/QuantumESPRESSOCommands.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MineralsCloud.github.io/QuantumESPRESSOCommands.jl/dev)
[![Build Status](https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/workflows/CI/badge.svg)](https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/actions)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/MineralsCloud/QuantumESPRESSOCommands.jl?svg=true)](https://ci.appveyor.com/project/singularitti/QuantumESPRESSOCommands-jl)
[![pipeline status](https://gitlab.com/singularitti/QuantumESPRESSOCommands.jl/badges/master/pipeline.svg)](https://gitlab.com/singularitti/QuantumESPRESSOCommands.jl/builds)
[![Build Status](https://cloud.drone.io/api/badges/MineralsCloud/QuantumESPRESSOCommands.jl/status.svg)](https://cloud.drone.io/MineralsCloud/QuantumESPRESSOCommands.jl)
[![Build Status](https://api.cirrus-ci.com/github/MineralsCloud/QuantumESPRESSOCommands.jl.svg)](https://cirrus-ci.com/github/MineralsCloud/QuantumESPRESSOCommands.jl)
[![Coverage](https://codecov.io/gh/MineralsCloud/QuantumESPRESSOCommands.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/MineralsCloud/QuantumESPRESSOCommands.jl)
[![Coverage](https://coveralls.io/repos/github/MineralsCloud/QuantumESPRESSOCli.jl/badge.svg?branch=master)](https://coveralls.io/github/MineralsCloud/QuantumESPRESSOCli.jl?branch=master)

## Installation

`QuantumESPRESSOCommands` is a <a href="https://julialang.org"><img src="https://julialang.org/assets/infra/julia.ico" width="16em">Julia Language</a> package.
To install `QuantumESPRESSOCommands`, please <a href="https://docs.julialang.org/en/v1/manual/getting-started/">open
Julia's interactive session (known as REPL)</a> and press <kbd>]</kbd> key in the REPL to use the package mode, then type the following commands:

For stable release

```julia
pkg> add QuantumESPRESSOCommands
```

For current master

```julia
pkg> add QuantumESPRESSOCommands#master
```

### Command Line Interface

Add `~/.julia/bin` to your `PATH` to enable command line interface. Or run
`QuantumESPRESSOCommands.comonicon_install_path()` to install everything automatically.

Sometimes, you won't trigger the package `build` of Julia. You can install the command line interface
manually via `QuantumESPRESSOCommands.comonicon_install()`.

### Completions

If you are using ZSH, you can enable the auto-completion by `QuantumESPRESSOCommands.comonicon_install_path()`. Or add the `FPATH`
to your `.zshrc`

```sh
export FPATH="$HOME/.julia/completions:$FPATH"
```

if you do not have [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) installed, you need to add

```sh
autoload -Uz compinit && compinit
```

to your `.zshrc` as well.
