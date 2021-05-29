module Commands

using Configurations: @option

export MpiexecConfig

abstract type CommandConfig end

@option struct MpiexecConfig <: CommandConfig
    exe::String = "mpiexec"
    np::UInt = 0
    options::Dict{String,Any} = Dict()
end

end
