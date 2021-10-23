module Commands

using Compat: addenv
using Configurations: from_kwargs, @option
@static if VERSION >= v"1.6"
    using Preferences: @load_preference
end

export mpiexec

@static if VERSION >= v"1.6"
    const mpiexec_path = @load_preference("mpiexec path", "mpiexec")
else
    const mpiexec_path = "mpiexec"
end

"Represent the configurations of a command."
abstract type CommandConfig end

"""
    mpiexec(config::MpiexecOptions)
    mpiexec(; kwargs...)

Construct an `mpiexec` from `kwargs` or an `MpiexecOptions`.
"""
function mpiexec(config::MpiexecOptions)
    args = [mpiexec_path]
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
        return addenv(cmd, config.env)
    end
end
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecOptions; kwargs...))

end
