module Commands

using Configurations: @option

export MpiexecConfig

"Represent the configurations of a command."
abstract type CommandConfig end

"""
    MpiexecConfig(; exe="mpiexec", np=0, options=Dict())

Represent an `mpiexec` executable.

# Arguments
- `exe::String="mpiexec"`: the path to the executable.
- `np::UInt=0`: the number of processes used. If `np` is zero, it means no parallelization is performed.
- `options::Dict{String,Any}=Dict()`: the options of `mpiexec`. See ["mpiexec(1) man page"](https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php).
"""
@option struct MpiexecConfig <: CommandConfig
    np::UInt = 1
    options::Dict{String,Any} = Dict()
end

end
