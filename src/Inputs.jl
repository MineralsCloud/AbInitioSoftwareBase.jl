module Inputs

export Input, inputstring, titleof, write_input

"An abstract type representing an input object of ab initio software."
abstract type Input end

"Return a `String` that represents the input of the software. Need to be implemented."
function inputstring end

function titleof end

"""
    write_input(file, object::Input, dry_run = false)

Write `object` to `file`. Use `dry_run = true` to print without actual writing.
"""
function write_input(file, object::Input, dry_run = false)
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
            write(io, inputstring(object))
        end
    end
    return
end

end
