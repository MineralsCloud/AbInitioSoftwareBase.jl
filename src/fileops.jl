import JSON
using IsURL: isurl
import YAML
import Pkg.TOML

export load, save, loads, of_format

struct DataFormat{T} end

format(::Val{:json}) = DataFormat{:JSON}()
format(::Union{Val{:yaml},Val{:yml}}) = DataFormat{:YAML}()
format(::Val{:toml}) = DataFormat{:TOML}()

"""
    save(file, data)

Save `data` to `file`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.

If `data` is a `Dict`, its keys should be `String`s so that `load` can return the same `data`.

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

"""
    load(file)

Load data from `file` to a `Dict`.

By now, `YAML`, `JSON`, and `TOML` formats are supported. The format is recognized by `file` extension.
"""
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
    loads(str, format)

Load data from `str` to a `Dict`. Allowed formats are `"yaml"`, `"yml"`, `"json"` and `"toml"`.
"""
loads(str, ::DataFormat{:JSON}) = JSON.parse(str)
loads(str, ::DataFormat{:TOML}) = TOML.parse(str)
loads(str, ::DataFormat{:YAML}) = YAML.load(str)

"""
    of_format(to, from)

Convert `from` to the format of `to`. Similar to `oftype`.
"""
function of_format(to, from)
    data = load(from)
    return save(to, data)
end

"""
    parentdir(file)

Get the directory of a `file`.

The problem of `dirname` is that it returns an empty string if users do not write `"./"` in the `file` path. This will cause an error in `tempname`.
"""
parentdir(file) = dirname(abspath(expanduser(file)))

"""
    extension(file)

Get the extension from `file`. Return an empty string if no extension is found.
"""
function extension(file)
    ext = splitext(file)[2]  # `splitext` works from `FilePathsBase.AbstractPath` since version 0.7.0.
    return isempty(ext) ? "" : lowercase(ext[2:end])
end
