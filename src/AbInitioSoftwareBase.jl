module AbInitioSoftwareBase

export Software

abstract type Software end

include("Inputs.jl")
include("Outputs.jl")
include("CLI.jl")

end
