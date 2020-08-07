module Inputs

export Input,
    inputstring,
    titleof,
    writeinput,
    setverbosity,
    set_elec_temp,
    set_press_vol,
    setcell

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
    writeinput(file, object::Input, dry_run::Bool = false)

Write an `Input` object to `file` or `io`. Use `dry_run = true` to preview changes.
"""
function writeinput(file, object::Input, dry_run::Bool = false)
    if dry_run
        if isfile(file)
            @warn "file `$file` will be overwritten!"
        else
            @warn "file `$file` will be created!"
        end
        print(inputstring(object))
    else
        mkpath(dirname(file))
        open(file, "w") do io
            writeinput(io, object)
        end
    end
    return
end  # See https://github.com/JuliaLang/julia/blob/3608c84/stdlib/DelimitedFiles/src/DelimitedFiles.jl#L787-L791

include("Formats.jl")

function setverbosity end

function set_elec_temp end

function set_press_vol end

function setcell end

end
