module CLI

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

function scriptify end

end
