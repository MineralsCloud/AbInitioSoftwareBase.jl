module Inputs

export Input,
    inputstring,
    groupname,
    writeinput,
    set_verbosity,
    set_elec_temp,
    set_press_vol,
    set_cell

"An abstract type representing an input object of ab initio software."
abstract type Input end

abstract type InputEntry end  # Define this to make the `eltype` not `Any` if both `Namelist` & `Card` exist.

"""
    Namelist <: InputEntry

The abstraction of an component of a `Input`, a basic Fortran data structure.
"""
abstract type Namelist <: InputEntry end

"Return an `AbstractString,` that represents the input of the software. Need to be implemented."
function inputstring end

function groupname end

"""
    writeinput(io::IO, object::Input)
    writeinput(file, object::Input)

Write an `Input` object to `file` or `io` using corresponding string format.
"""
function writeinput(io::IO, object::Input)
    write(io, inputstring(object))
    return
end
function writeinput(file, object::Input)
    mkpath(dirname(file))
    open(file, "w") do io
        writeinput(io, object)
    end
end  # See https://github.com/JuliaLang/julia/blob/3608c84/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L787-L791

include("Formatter.jl")

function set_verbosity end

function set_elec_temp end

function set_press_vol end

function set_cell end
abstract type Setter end

end
