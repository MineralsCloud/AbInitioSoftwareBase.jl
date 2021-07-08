# AbInitioSoftwareBase

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://MineralsCloud.github.io/AbInitioSoftwareBase.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MineralsCloud.github.io/AbInitioSoftwareBase.jl/dev)
[![Build Status](https://github.com/MineralsCloud/AbInitioSoftwareBase.jl/workflows/CI/badge.svg)](https://github.com/MineralsCloud/AbInitioSoftwareBase.jl/actions)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/MineralsCloud/AbInitioSoftwareBase.jl?svg=true)](https://ci.appveyor.com/project/singularitti/AbInitioSoftwareBase-jl)
[![Build Status](https://cloud.drone.io/api/badges/MineralsCloud/AbInitioSoftwareBase.jl/status.svg)](https://cloud.drone.io/MineralsCloud/AbInitioSoftwareBase.jl)
[![Build Status](https://api.cirrus-ci.com/github/MineralsCloud/AbInitioSoftwareBase.jl.svg)](https://cirrus-ci.com/github/MineralsCloud/AbInitioSoftwareBase.jl)
[![pipeline status](https://gitlab.com/singularitti/AbInitioSoftwareBase.jl/badges/master/pipeline.svg)](https://gitlab.com/singularitti/AbInitioSoftwareBase.jl/-/pipelines)
[![coverage report](https://gitlab.com/singularitti/AbInitioSoftwareBase.jl/badges/master/coverage.svg)](https://gitlab.com/singularitti/AbInitioSoftwareBase.jl/-/jobs)
[![Coverage](https://codecov.io/gh/MineralsCloud/AbInitioSoftwareBase.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/MineralsCloud/AbInitioSoftwareBase.jl)
[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/organization/repository)

`AbInitioSoftwareBase.jl` is an interface package that defines some common API
shared by some packages that represent different *ab initio* software like
[Quantum ESPRESSO](https://www.quantum-espresso.org/), [VASP](https://www.vasp.at/), etc.
The API will be extended in
[`QuantumESPRESSOBase.jl`](https://github.com/MineralsCloud/QuantumESPRESSOBase.jl), etc.

The code is [hosted on GitHub](https://github.com/MineralsCloud/AbInitioSoftwareBase.jl),
with some continuous integration services to test its validity.

## Compatibility

- [Julia version: `v1.0.0` to `v1.6.1`](https://julialang.org/downloads/)
- Dependencies:
  - [`Configurations.jl`](https://github.com/Roger-luo/Configurations.jl) `v0.3.0` and above
  - [`IsURL.jl`](https://github.com/zlatanvasovic/IsURL.jl) `v0.2.0` and above
  - [`JSON.jl`](https://github.com/JuliaIO/JSON.jl) `v0.20.0` and above
  - [`TOML.jl`](https://github.com/JuliaLang/TOML.jl) `v1.0` and above
  - [`YAML.jl`](https://github.com/JuliaData/YAML.jl) `v0.3.0` and above
- OS: macOS, Linux, Windows, and FreeBSD
- Architecture: x86, x64, ARM

## Installation

To install `Spglib`, please open Julia's interactive session (known as REPL) and
press `]` key in the REPL to use the [package mode](https://docs.julialang.org/en/v1/stdlib/Pkg/),
then type the following command

For stable release

```julia
(@v1.6) pkg> add AbInitioSoftwareBase
```

For current master

```julia
(@v1.6) pkg> add AbInitioSoftwareBase#master
```

## Contributors

This repository is created and maintained by [singularitti](https://github.com/singularitti).
You are very welcome to contribute.
