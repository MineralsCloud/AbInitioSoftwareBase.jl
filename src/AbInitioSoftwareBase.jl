module AbInitioSoftwareBase

export QE

abstract type AbInitioSoftware end
struct QuantumESPRESSO <: AbInitioSoftware end
const QE = QuantumESPRESSO

include("fileops.jl")
include("Inputs.jl")
include("Outputs.jl")
include("CLI.jl")

end
