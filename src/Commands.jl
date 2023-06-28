module Commands

using Preferences: @load_preference, @set_preferences!, @delete_preferences!

export Mpiexec

getpath() = @load_preference("mpiexec path", "mpiexec")

function setpath(path::String)
    @assert ispath(path)
    @set_preferences!("mpiexec path" => path)
end

unsetpath() = @delete_preferences!("mpiexec path")

struct Mpiexec
    path::String
    env::Tuple
    options::Iterators.Pairs
end
"""
    Mpiexec(path, env...; options...)

Create a `Mpiexec` functor.
"""
Mpiexec(path, env::Pair...; options...) =
    Mpiexec(path, Tuple(string(key) => string(value) for (key, value) in env), options)

"""
    (mpiexec::Mpiexec)(exec...)

Create a `Cmd` object from an `Mpiexec` functor and a set of arguments.
"""
function (mpiexec::Mpiexec)(exec...)
    args = _expandargs(mpiexec)
    push!(args, exec...)
    cmd = Cmd(args)
    return setenv(cmd, mpiexec.env)
end

function _expandargs(mpiexec::Mpiexec)
    args = [mpiexec.path]
    for (arg, val) in mpiexec.options
        if arg in (:env, :genv, :envlist, :genvlist)
            throw(ArgumentError("Please treat `$arg` as a positional argument `env`."))
        end
        _pusharg!(args, string(arg), val)
    end
    return args
end

function _pusharg!(args, arg, val)
    arg = replace(arg, '_' => '-')
    option = (arg in LONG_OPTIONS ? "--" : '-') * arg
    if val isa AbstractVector{<:AbstractString}
        join(val, ',')
        return push!(args, option, val)
    elseif val isa Bool  # flag
        return push!(args, option)
    elseif val isa Pair
        return push!(args, option, string(val.first), string(val.second))
    elseif val isa AbstractVector{<:Pair} || val isa AbstractDict
        for v in val
            push!(args, option, string(v.first), string(v.second))
        end
    else
        return push!(args, option, string(val))
    end
end

end
