using QuantumESPRESSOCli
using Documenter

makedocs(;
    modules=[QuantumESPRESSOCli],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/QuantumESPRESSOCli.jl/blob/{commit}{path}#L{line}",
    sitename="QuantumESPRESSOCli.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/QuantumESPRESSOCli.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/QuantumESPRESSOCli.jl",
)
