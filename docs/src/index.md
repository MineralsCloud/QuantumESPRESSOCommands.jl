```@meta
CurrentModule = QuantumESPRESSOCommands
```

# QuantumESPRESSOCommands

`QuantumESPRESSOCommands` is a <a href="https://julialang.org"><img src="https://julialang.org/assets/infra/julia.ico" width="16em">Julia Language</a> package.
It is used to build some QuantumESPRESSO commands from Julia functions and types,
and run from shell (scripts).

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

## Manual Outline

```@contents
Pages = [
    "installation.md",
    "develop.md",
    "usage.md",
    "api.md",
]
Depth = 3
```

## Index

```@index
```
