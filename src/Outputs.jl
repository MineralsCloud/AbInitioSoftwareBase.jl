module Outputs

using UrlDownload: File, URL, urldownload

function readoutput(str::AbstractString, parser = nothing)
    function (args...; kwargs...)
        if isnothing(parser)
            return str
        else
            return parser(str, args...; kwargs...)  # `parseoutput` will be used here
        end
    end
end
function readoutput(url_or_file::Union{URL,File}, parser = nothing)
    str = urldownload(url_or_file, true; parser = String)
    return readoutput(str, parser)
end
function readoutput(file, parser = nothing)
    open(file, "r") do io
        str = read(io, String)
        return readoutput(str, parser)
    end
end

end
