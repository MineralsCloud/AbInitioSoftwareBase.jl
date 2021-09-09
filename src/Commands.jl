module Commands

using Compat: addenv
using Configurations: from_kwargs, @option
import MPICH_jll

export MpiexecOptions, MpiexecConfig, mpiexec

"Represent the configurations of a command."
abstract type CommandConfig end

"""
    MpiexecOptions(; <keyword arguments>)

Represent the options of command `mpiexec`.

# Arguments
- `f::String=""`: file containing the host names.
- `hosts::Vector{String}`: comma separated host list.
- `wdir::String`: working directory to use.
- `configfile::String`: config file containing MPMD launch options.
- `np::UInt=1`: the number of processes used.
"""
@option struct MpiexecOptions <: CommandConfig
    path::String = "mpiexec"
    f::String = ""
    hosts::Vector{String} = String[]
    wdir::String = ""
    configfile::String = ""
    env::Union{Dict,Vector} = Dict(ENV)
    np::UInt = 1
end

const MpiexecConfig = MpiexecOptions

"""
    mpiexec(config::MpiexecOptions)
    mpiexec(; kwargs...)

Construct an `mpiexec` from `kwargs` or an `MpiexecOptions`.
"""
function mpiexec(config::MpiexecOptions)
    args = [MPICH_jll.mpiexec_path]
    for field in (:f, :wdir, :configfile)
        if !isempty(getfield(config, field))
            push!(args, "-$field", getfield(config, field))
        end
    end
    if !isempty(getfield(config, :hosts))
        push!(args, "-hosts", join(getfield(config, :hosts), ','))
    end
    push!(args, "-np", string(config.np))
    return function (exec; kwargs...)
        append!(args, exec)
        cmd = Cmd(Cmd(args); kwargs...)
        return addenv(cmd, MPICH_jll.mpiexec().env)
    end
end
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecOptions; kwargs...))

end
