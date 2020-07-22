module Inputs

export Input, inputstring, titleof, writeinput

"An abstract type representing an input object of ab initio software."
abstract type Input end

"Return a `String` that represents the input of the software. Need to be implemented."
function inputstring end

function titleof end

function writeinput(io::IO, object::Input)
    write(io, inputstring(object))
    return
end # function writeinput
"""
    writeinput(io::IO, object::Input)
    writeinput(file, object::Input)

Write an `Input` object to `file` or `io`.
"""
function writeinput(file, object::Input)
    if isfile(file)
        @warn "file `$file` will be overwritten!"
    else
        @warn "file `$file` will be created!"
    end
    mkpath(dirname(file))
    open(file, "w") do io
        write(io, inputstring(object))
    end
    return
end  # See https://github.com/JuliaLang/julia/blob/3608c84/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L787-L791

include("Formats.jl")

end