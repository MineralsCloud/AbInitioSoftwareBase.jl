using AbInitioSoftwareBase
using Documenter

makedocs(;
    modules = [AbInitioSoftwareBase],
    authors = "Qi Zhang <singularitti@outlook.com>",
    repo = "https://github.com/MineralsCloud/AbInitioSoftwareBase.jl/blob/{commit}{path}#L{line}",
    sitename = "AbInitioSoftwareBase.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://MineralsCloud.github.io/AbInitioSoftwareBase.jl",
        assets = String[],
    ),
    pages = [
        "Home" => "index.md",
        "Manual" => ["Installation" => "install.md", "Development" => "develop.md"],
        "Troubleshooting" => "troubleshooting.md",
        "API by module" => [
            "`AbInitioSoftwareBase` module" => "api/AbInitioSoftwareBase.md",
            "`Inputs` module" => "api/Inputs.md",
            "`CLI` module" => "api/CLI.md",
        ],
    ],
)

deploydocs(; repo = "github.com/MineralsCloud/AbInitioSoftwareBase.jl")
