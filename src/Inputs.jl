module Inputs

export Input, inputstring, groupname, writeinput

"An abstract type representing an input object of ab initio software."
abstract type Input end

abstract type InputEntry end  # Define this to make the `eltype` not `Any` if both `Namelist` & `Card` exist.

"""
    Namelist <: InputEntry

The abstraction of an component of a `Input`, a basic Fortran data structure.
"""
abstract type Namelist <: InputEntry end

"Return a `String` representation of the input of the software. To be implemented."
function inputstring end

function groupname end

"""
    writeinput(io::IO, input::Input)
    writeinput(file, input::Input)

Write an `Input` object to `file` or `io` using corresponding string format.
"""
function writeinput(io::IO, input::Input)
    write(io, inputstring(input))
    return
end
function writeinput(file, input::Input)
    open(file, "w") do io
        writeinput(io, input)
    end
end  # See https://github.com/JuliaLang/julia/blob/3608c84/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L787-L791

include("Formatter.jl")

abstract type Setter end

end
