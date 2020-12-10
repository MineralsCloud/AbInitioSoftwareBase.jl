import JSON
using IsURL: isurl
import YAML
import Pkg.TOML

export load, save, loads

"""
    savefile(file, data)

Save `data` to `file`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.

!!! warning
    Allowed `data` types can be referenced in [`JSON.jl` documentation](https://github.com/JuliaIO/JSON.jl/blob/master/README.md)
    and [`YAML.jl` documentation](https://github.com/JuliaData/YAML.jl/blob/master/README.md).
    For `TOML` format, only `AbstractDict` type is allowed.
"""
function save(file, data)
    ext, path = extension(file), expanduser(file)
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
        error("unsupported file extension `$ext`!")
    end
end

"""
    loadfile(file)

Load data from `file` to a `Dict`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.
"""
load(parser, url_or_file) = parser(filepath(url_or_file))
function load(url_or_file)
    path = filepath(url_or_file)
    ext = extension(path)
    if ext ∈ ("yaml", "yml")
        return open(path, "r") do io
            YAML.load(io)
        end
    elseif ext == "json"
        return JSON.parsefile(path)
    elseif ext == "toml"
        return TOML.parsefile(path)
    else
        error("unsupported file extension `$ext`! Please provide a `parser`!")
    end
end

function filepath(url_or_file)
    if isurl(url_or_file)
        return download(url_or_file, joinpath(mktempdir(), basename(url_or_file)))
    else
        if isfile(url_or_file)
            return expanduser(url_or_file)
        else
            error("file \"$url_or_file\" does not exists!")
        end
    end
end

"""
    loadstring(format, str)

Load data from `str` to a `Dict`. Allowed formats are `"yaml"`, `"yml"`, `"json"` and `"toml"`.
"""
function loads(format::AbstractString, str)
    format = lowercase(string(format))
    if format ∈ ("yaml", "yml")
        return YAML.load(str)
    elseif format == "json"
        return JSON.parse(str)
    elseif format == "toml"
        return TOML.parse(str)
    else
        error("unsupported format: `$format`!")
    end
end
loads(parser, str) = parser(str)

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