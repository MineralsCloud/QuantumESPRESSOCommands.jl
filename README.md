# QuantumESPRESSOCli

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://MineralsCloud.github.io/QuantumESPRESSOCli.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MineralsCloud.github.io/QuantumESPRESSOCli.jl/dev)
[![Build Status](https://github.com/MineralsCloud/QuantumESPRESSOCli.jl/workflows/CI/badge.svg)](https://github.com/MineralsCloud/QuantumESPRESSOCli.jl/actions)
[![Build Status](https://travis-ci.com/MineralsCloud/QuantumESPRESSOCli.jl.svg?branch=master)](https://travis-ci.com/MineralsCloud/QuantumESPRESSOCli.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/MineralsCloud/QuantumESPRESSOCli.jl?svg=true)](https://ci.appveyor.com/project/MineralsCloud/QuantumESPRESSOCli-jl)
[![Build Status](https://cloud.drone.io/api/badges/MineralsCloud/QuantumESPRESSOCli.jl/status.svg)](https://cloud.drone.io/MineralsCloud/QuantumESPRESSOCli.jl)
[![Build Status](https://api.cirrus-ci.com/github/MineralsCloud/QuantumESPRESSOCli.jl.svg)](https://cirrus-ci.com/github/MineralsCloud/QuantumESPRESSOCli.jl)
[![Coverage](https://codecov.io/gh/MineralsCloud/QuantumESPRESSOCli.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/MineralsCloud/QuantumESPRESSOCli.jl)
[![Coverage](https://coveralls.io/repos/github/MineralsCloud/QuantumESPRESSOCli.jl/badge.svg?branch=master)](https://coveralls.io/github/MineralsCloud/QuantumESPRESSOCli.jl?branch=master)

## Installation
<p>
QuantumESPRESSOCli is a &nbsp;
    <a href="https://julialang.org">
        <img src="https://julialang.org/favicon.ico" width="16em">
        Julia Language
    </a>
    &nbsp; package. To install QuantumESPRESSOCli,
    please <a href="https://docs.julialang.org/en/v1/manual/getting-started/">open
    Julia's interactive session (known as REPL)</a> and press <kbd>]</kbd> key in the REPL to use the package mode, then type the following command
</p>

For stable release

```julia
pkg> add QuantumESPRESSOCli
```

For current master

```julia
pkg> add QuantumESPRESSOCli#master
```

### Command Line Interface

Add `~/.julia/bin` to your `PATH` to enable command line interface. Or run
`QuantumESPRESSOCli.comonicon_install_path()` to install everything automatically.

Sometimes, you won't trigger the package `build` of Julia. You can install the command line interface
manually via `QuantumESPRESSOCli.comonicon_install()`.

### Completions

If you are using ZSH, you can enable the auto-completion by `QuantumESPRESSOCli.comonicon_install_path()`. Or add the `FPATH`
to your `.zshrc`

```sh
export FPATH="$HOME/.julia/completions:$FPATH"
```

if you do not have [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) installed, you need to add

```sh
autoload -Uz compinit && compinit
```

to your `.zshrc` as well.
