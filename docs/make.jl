using AbInitioSoftwareBase
using Documenter

DocMeta.setdocmeta!(AbInitioSoftwareBase, :DocTestSetup, :(using AbInitioSoftwareBase); recursive=true)

makedocs(;
    modules=[AbInitioSoftwareBase],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/MineralsCloud/AbInitioSoftwareBase.jl/blob/{commit}{path}#{line}",
    sitename="AbInitioSoftwareBase.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/AbInitioSoftwareBase.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "Installation guide" => "installation.md",
        ],
        "API Reference" => "api.md",
        "Developer Docs" => [
            "Contributing" => "developers/contributing.md",
            "Style Guide" => "developers/style-guide.md",
            "Design Principles" => "developers/design-principles.md",
        ],
        "Troubleshooting" => "troubleshooting.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/AbInitioSoftwareBase.jl",
    devbranch="main",
)
