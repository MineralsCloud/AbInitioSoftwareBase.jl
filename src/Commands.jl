module Commands

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
    np::UInt = 1
    options::Dict{String,Any} = Dict()
end

function mpiexec(config::MpiexecConfig)
    args = [MPICH_jll.mpiexec_path, "-n", string(config.np)]
    for (k, v) in config.options
        push!(args, k, string(v))
    end
    return function (main::AbstractVector; env = String[], kwargs...)
        append!(args, main)
        cmd = Cmd(args)
        if isempty(env)
            return Cmd(cmd; env = MPICH_jll.mpiexec().env, kwargs...)
        else
            return Cmd(cmd; env = env, kwargs...)
        end
    end
end
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecConfig; kwargs...))

end
