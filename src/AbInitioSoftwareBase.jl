module AbInitioSoftwareBase

export Software

abstract type Software end

include("fileops.jl")
include("Inputs.jl")
include("Outputs.jl")
include("CLI.jl")

end
