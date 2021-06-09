```@meta
CurrentModule = AbInitioSoftwareBase
```

# AbInitioSoftwareBase

`AbInitioSoftwareBase.jl` is an interface package that defines some common API
shared by some packages that represent different *ab initio* software like
[Quantum ESPRESSO](https://www.quantum-espresso.org/), [VASP](https://www.vasp.at/), etc.
The API will be extended in
[`QuantumESPRESSOBase.jl`](https://github.com/MineralsCloud/QuantumESPRESSOBase.jl), etc.

The code is [hosted on GitHub](https://github.com/MineralsCloud/AbInitioSoftwareBase.jl),
with some continuous integration services to test its validity.

This repository is created and maintained by [singularitti](https://github.com/singularitti).
You are very welcome to contribute.

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

## Manual Outline

```@contents
Pages = [
    "install.md",
    "develop.md",
    "troubleshooting.md",
    "api/AbInitioSoftwareBase.md",
]
Depth = 3
```

### [Index](@id main-index)

```@index
```
