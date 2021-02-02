module CLI

using Configurations: @option

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

@option struct MpiexecPath
    path::String = "mpiexec"
end

end
