module CLI

using Preferences: @load_preference, @set_preferences!, @has_preference

export Executable, Mpiexec, scriptify

abstract type Executable end
"""
    Mpiexec(np; bin = "mpiexec", host = [], hostfile = "", args = Pair[])

Represent the `mpiexec` or `mpirun` executable. Must be combined with an actual command.

Type `?Mpiexec.host` to see the documentation of the `host` parameter, and so on.
"""
struct Mpiexec <: Executable
    "Specify the number of processes to use."
    np::UInt
    "Path to the `mpiexec` or `mpirun` executable."
    args::Vector{<:Pair}
end
Mpiexec(np::Integer, args::AbstractVector{<:Pair}) = Mpiexec(np, args)
Mpiexec(np::Integer) = Mpiexec(np, Pair[])

function scriptify end

const string_nameof = string ∘ nameof

function setbinpath(T::Type{<:Executable}, path)
    @set_preferences!(string_nameof(T) => path)
end
function binpath(T::Type{<:Executable})
    return @load_preference(string_nameof(T))
end
binpath(x::Executable) = binpath(typeof(x))

if !@has_preference("Mpiexec")
    @set_preferences!("Mpiexec" => "mpiexec")
end

end
