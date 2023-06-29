module Commands

using CommandComposer: ShortOption, LongOption
using Preferences: @load_preference, @set_preferences!, @delete_preferences!

import CommandComposer: Command

export Mpiexec

getpath() = @load_preference("mpiexec path", "mpiexec")

function setpath(path::String)
    @assert ispath(path)
    @set_preferences!("mpiexec path" => path)
end

unsetpath() = @delete_preferences!("mpiexec path")

abstract type Executable end
# See https://github.com/JuliaLang/julia/blob/3fa2d26/base/operators.jl#L1078-L1083 & https://github.com/JuliaGeometry/CoordinateTransformations.jl/blob/ff9ea6e/src/core.jl#L29-L32
struct ExecutableChain{A<:Executable,B<:Executable}
    a::A
    b::B
end

struct Mpiexec <: Executable
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
function Command(mpiexec::Mpiexec)
    options = map(keys(mpiexec.options), values(mpiexec.options)) do key, value
        if length(string(key)) <= 2
            ShortOption(string(key), value)
        else
            LongOption(string(key), value)
        end
    end
    return Command(mpiexec.path, options, [], [])
end

# See https://github.com/JuliaLang/julia/blob/3fa2d26/base/operators.jl#L1088
Base.:∘(a::Executable, b::Executable) = ExecutableChain(a, b)

# See https://github.com/JuliaGeometry/CoordinateTransformations.jl/blob/ff9ea6e/src/core.jl#L34
Base.show(io::IO, chain::ExecutableChain) = print(io, '(', chain.a, " ∘ ", chain.b, ')')

end
