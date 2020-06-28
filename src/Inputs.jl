module Inputs

export Input, inputstring, titleof, write_input

abstract type Input end

function inputstring end

function titleof end

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
