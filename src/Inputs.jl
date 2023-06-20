export groupname, writetxt, getpseudodir, listpotentials

"""
    Input

An abstract type representing an input object of ab initio software. All other input types should subtype `Input`.
"""
abstract type Input end

"""
    InputEntry

Represent any component of an `Input`. The fields of an `Input` should all be either `InputEntry` or `Nothing` (no value provided).
"""
abstract type InputEntry end  # Define this to make the `eltype` not `Any` if both `Namelist` & `Card` exist.

"""
    Namelist <: InputEntry

Represent a component of an `Input`, a basic Fortran data structure.
"""
abstract type Namelist <: InputEntry end

"""
    Card <: InputEntry

Represent `CAR` or cards of an `Input` in VASP, Quantum ESPRESSO, etc.
"""
abstract type Card <: InputEntry end

"""
    groupname(x::InputEntry)

Get the group name of an `InputEntry`.

The definition `groupname(x) = groupname(typeof(x))` is provided for convenience
so that instances can be passed instead of types.
"""
groupname(x::InputEntry) = groupname(typeof(x))

Base.iterate(nml::Namelist) = (fieldname(typeof(nml), 1) => getfield(nml, 1), 2)
Base.iterate(nml::Namelist, i) =
    i < 1 || i > nfields(nml) ? nothing :
    (fieldname(typeof(nml), i) => getfield(nml, i), i + 1)

Base.length(nml::Namelist) = nfields(nml)

"""
    writetxt(filename::AbstractString, input::Input)

Write an `Input` object to a file in plain-text format.
"""
function writetxt(filename, input::Input)
    open(filename, "w") do io
        print(io, input)
    end
end  # See https://github.com/JuliaLang/julia/blob/0f4c8b0/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L788-L792

include("format.jl")

abstract type Setter end

function getpseudodir end

function listpotentials end
