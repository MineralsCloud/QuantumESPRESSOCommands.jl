using QuantumESPRESSOCommands
using Documenter

DocMeta.setdocmeta!(QuantumESPRESSOCommands, :DocTestSetup, :(using QuantumESPRESSOCommands); recursive=true)

makedocs(;
    modules=[QuantumESPRESSOCommands],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/blob/{commit}{path}#{line}",
    sitename="QuantumESPRESSOCommands.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/QuantumESPRESSOCommands.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "Installation" => "installation.md",
            "Development" => "develop.md",
            "Usage" => "usage.md",
        ],
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/QuantumESPRESSOCommands.jl",
)
