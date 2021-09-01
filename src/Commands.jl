module Commands

using Compat: addenv
using Configurations: from_kwargs, @option
import MPICH_jll

export MpiexecOptions, MpiexecConfig, mpiexec

"Represent the configurations of a command."
abstract type CommandConfig end

"""
    MpiexecOptions(; np=1, kwargs...)

Represent the options of command `mpiexec`.

# Arguments
- `f::String=""`: file containing the host names.
- `hosts::Vector{String}`: comma separated host list.
- `wdir::String`: working directory to use.
- `configfile::String`: config file containing MPMD launch options.
- `np::UInt=1`: the number of processes used.
"""
@option struct MpiexecOptions <: CommandConfig
    f::String = ""
    hosts::Vector{String} = String[]
    wdir::String = ""
    configfile::String = ""
    np::UInt = 1
end

const MpiexecConfig = MpiexecOptions

"""
    mpiexec(config::MpiexecConfig)
    mpiexec(; kwargs...)

Construct an `mpiexec` from `kwargs` or an `MpiexecConfig`.
"""
function mpiexec(config::MpiexecOptions)
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
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecOptions; kwargs...))

end
