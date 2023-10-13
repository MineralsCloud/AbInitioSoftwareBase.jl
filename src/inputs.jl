export groupname, writetxt, getpseudodir, eachpotential

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
function Base.iterate(nml::Namelist, i)
    if i < 1 || i > nfields(nml)
        return nothing
    else
        return (fieldname(typeof(nml), i) => getfield(nml, i), i + 1)
    end
end

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

function eachpotential end

struct EachPotential{N,A,B}
    atoms::NTuple{N,A}
    potentials::NTuple{N,B}
end

# Similar to https://github.com/JuliaCollections/IterTools.jl/blob/0ecaa88/src/IterTools.jl#L1028-L1032
function Base.iterate(iter::EachPotential, state=1)
    if state > length(iter)
        return nothing
    else
        return (iter.atoms[state], iter.potentials[state]), state + 1
    end
end

Base.eltype(::Type{EachPotential{N,A,B}}) where {N,A,B} = Tuple{A,B}

Base.length(::EachPotential{N}) where {N} = N

Base.IteratorSize(::Type{<:EachPotential}) = Base.HasLength()
