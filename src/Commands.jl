module Commands

using Compat: addenv
using Configurations: from_kwargs, @option
import MPICH_jll

export MpiexecConfig, mpiexec

"Represent the configurations of a command."
abstract type CommandConfig end

"""
    MpiexecConfig(; np=1, options=Dict())

Represent an `mpiexec` executable.

# Arguments
- `np::UInt=1`: the number of processes used.
- `options::Dict{String,Any}=Dict()`: the options of `mpiexec`. See ["mpiexec(1) man page"](https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php).
"""
@option struct MpiexecConfig <: CommandConfig
    f::String = ""
    hosts::Vector{String} = String[]
    wdir::String = ""
    configfile::String = ""
    np::UInt = 1
end

"""
    mpiexec(config::MpiexecConfig)
    mpiexec(; kwargs...)

Construct an `mpiexec` from `kwargs` or an `MpiexecConfig`.
"""
function mpiexec(config::MpiexecConfig)
    args = [MPICH_jll.mpiexec_path]
    for field in (:f, :hosts, :wdir, :configfile)
        if !isempty(getfield(config, field))
            push!(args, '-', string(field), getfield(config, field))
        end
    end
    push!(args, "-np", string(config.np))
    return function (exec; kwargs...)
        append!(args, exec)
        cmd = Cmd(args; kwargs...)
        return addenv(cmd, MPICH_jll.mpiexec().env)
    end
end
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecConfig; kwargs...))

end
