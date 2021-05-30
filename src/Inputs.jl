module Inputs

export groupname, writetxt, asstring

"""
    Input

An abstract type representing an input object of ab initio software. All other input types should subtype `Input`.
"""
abstract type Input end

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
    groupname(::Namelist)

Get the group name of a `Namelist`.
"""
function groupname end

"""
    asstring(object, config::FormatConfig)
    asstring(object; kwargs...)

Return a string representing a qualified `Input` or part of an `Input`, with formatting arguments `FormatConfig` or `kwargs`.

See also: [`FormatConfig`](@ref)
"""
function asstring end

"""
    writeinput(io::IO, input::Input)
    writeinput(file, input::Input)

Write an `Input` object to `file` or `io` using corresponding string format.
"""
function writetxt(io::IO, input::Input)
    write(io, asstring(input))
    return
end
function writetxt(file, input::Input)
    open(file, "w") do io
        writetxt(io, input)
    end
end  # See https://github.com/JuliaLang/julia/blob/3608c84/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L787-L791

include("format.jl")

abstract type Setter end

end
