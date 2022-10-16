using QuantumESPRESSOCommands
using Documenter

DocMeta.setdocmeta!(QuantumESPRESSOCommands, :DocTestSetup, :(using QuantumESPRESSOCommands); recursive=true)

makedocs(;
    modules=[QuantumESPRESSOCommands],
    authors="singularitti <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/QuantumESPRESSOCommands.jl/blob/{commit}{path}#{line}",
    sitename="QuantumESPRESSOCommands.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/QuantumESPRESSOCommands.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "Installation guide" => "installation.md",
        ],
        # "API Reference" => "public.md",
        "Developer Docs" => [
            "Contributing" => "developers/contributing.md",
            "Style Guide" => "developers/style.md",
        ],
        "Troubleshooting" => "troubleshooting.md",
        # "FAQ" => "faq.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/QuantumESPRESSOCommands.jl",
)
