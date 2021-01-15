import JSON
using IsURL: isurl
import YAML
import Pkg.TOML

export load, save, loads

struct DataFormat{T} end

format(::Val{:json}) = DataFormat{:JSON}()
format(::Union{Val{:yaml},Val{:yml}}) = DataFormat{:YAML}()
format(::Val{:toml}) = DataFormat{:TOML}()

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
    path, ext = expanduser(file), extension(file)
    _save(path, format(Val(Symbol(ext))), data)
    return
end
function _save(f, ::DataFormat{:JSON}, data)
    open(f, "w") do io
        JSON.print(io, data)
    end
end
function _save(f, ::DataFormat{:TOML}, data::AbstractDict)
    open(f, "w") do io
        TOML.print(io, data)
    end
end
function _save(f, ::DataFormat{:YAML}, data)
    open(f, "w") do io
        YAML.write(io, data, "")
    end
end
# function save(file, data)
#     ext, path = extension(file), expanduser(file)
#     if ext ∈ ("yaml", "yml")
#         YAML.write_file(path, data)
#     elseif ext == "json"
#         open(path, "w") do io
#             JSON.print(io, data)
#         end
#     elseif ext == "toml"
#         typeassert(data, AbstractDict)
#         open(path, "w") do io
#             TOML.print(io, data)
#         end
#     else
#         error("unsupported file extension `$ext`!")
#     end
# end

"""
    load(file)

Load data from `file` to a `Dict`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.
"""
# function load(url_or_file)
#     path = filepath(url_or_file)
#     ext = extension(path)
#     if ext ∈ ("yaml", "yml")
#         return open(path, "r") do io
#             YAML.load(io)
#         end
#     elseif ext == "json"
#         return JSON.parsefile(path)
#     elseif ext == "toml"
#         return TOML.parsefile(path)
#     else
#         error("unsupported file extension `$ext`! Please provide a `parser`!")
#     end
# end
function load(url_or_file)
    path = filepath(url_or_file)
    ext = extension(path)
    _load(path, format(Val(Symbol(ext))))
end
_load(path, ::DataFormat{:JSON}) = JSON.parsefile(path)
function _load(path, ::DataFormat{:TOML})
    open(path, "r") do io
        TOML.parse(io)
    end
end
function _load(path, ::DataFormat{:YAML})
    open(path, "r") do io
        YAML.load(io)
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
    loads(format, str)

Load data from `str` to a `Dict`. Allowed formats are `"yaml"`, `"yml"`, `"json"` and `"toml"`.
"""
loads(str, ::DataFormat{:JSON}) = JSON.parse(str)
loads(str, ::DataFormat{:TOML}) = TOML.parse(str)
loads(str, ::DataFormat{:YAML}) = YAML.load(str)

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
