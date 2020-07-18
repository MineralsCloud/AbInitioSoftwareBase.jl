using JSON
using YAML
using Pkg.TOML
using FilePathsBase: AbstractPath

export FilePath, load, save

const FilePath = AbstractPath

"""
    save(file, data)

Save `data` to `file`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.

!!! warning
    Allowed `data` types can be referenced in [`JSON.jl` documentation](https://github.com/JuliaIO/JSON.jl/blob/master/README.md)
    and [`YAML.jl` documentation](https://github.com/JuliaData/YAML.jl/blob/master/README.md).
    For `TOML` format, only `AbstractDict` type is allowed.
"""
function save(file, data)
    ext, path = extension(file), abspath(expanduser(file))
    if ext ∈ ("yaml", "yml")
        YAML.write_file(path, data)
    elseif ext == "json"
        open(path, "w") do io
            JSON.print(io, data)
        end
    elseif ext == "toml"
        typeassert(data, AbstractDict)
        open(path, "w") do io
            TOML.print(io, data)
        end
    else
        error("unknown file extension `$ext`!")
    end
end # function save

"""
    load(file)

load data from `file` to a `Dict`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.
"""
function load(file)
    ext, path = extension(file), abspath(expanduser(file))
    if ext ∈ ("yaml", "yml")
        return open(path, "r") do io
            YAML.load(io)
        end
    elseif ext == "json"
        return JSON.parsefile(path)
    elseif ext == "toml"
        return TOML.parsefile(path)
    else
        error("unknown file extension `$ext`!")
    end
end # function load

"""
    extension(file)

Get the extension from `file`. Return an empty string if no extension is found.
"""
function extension(file)  # From https://github.com/rofinn/FilePathsBase.jl/blob/af850a4/src/path.jl#L331-L340
    name = basename(file)
    tokenized = split(name, '.')
    if length(tokenized) > 1
        return lowercase(tokenized[end])
    else
        return ""
    end
end
