using JSON
using YAML
using Pkg.TOML

export load, save

function save(filepath, data)
    ext, fp = extension(filepath), abspath(expanduser(filepath))
    if ext ∈ ("yaml", "yml")
        YAML.write_file(fp, data)
    elseif ext == "json"
        open(fp, "w") do io
            JSON.print(io, data)
        end
    elseif ext == "toml"
        typeassert(data, AbstractDict)
        open(fp, "w") do io
            TOML.print(io, data)
        end
    else
        error("unknown file extension `$ext`!")
    end
end # function save

function load(filepath)
    ext, fp = extension(filepath), abspath(expanduser(filepath))
    if ext ∈ ("yaml", "yml")
        return open(fp, "r") do io
            YAML.load(io)
        end
    elseif ext == "json"
        return JSON.parsefile(fp)
    elseif ext == "toml"
        return TOML.parsefile(fp)
    else
        error("unknown file extension `$ext`!")
    end
end # function load

function extension(filepath)  # From https://github.com/rofinn/FilePathsBase.jl/blob/af850a4/src/path.jl#L331-L340
    name = basename(filepath)
    tokenized = split(name, '.')
    if length(tokenized) > 1
        return lowercase(tokenized[end])
    else
        return ""
    end
end
