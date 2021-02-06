module Cli

using Configurations: @option

export MpiexecOptions

abstract type CliConfig end

@option struct MpiexecOptions
    exe::String = "mpiexec"
    np::UInt = 0
    options::Dict{String,Any} = Dict()
end

end
