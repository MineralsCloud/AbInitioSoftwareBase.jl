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

end
