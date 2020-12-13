module AbInitioSoftwareBase

abstract type AbInitioSoftware end

include("fileops.jl")
include("Inputs.jl")
include("Outputs.jl")
include("CLI.jl")

end
