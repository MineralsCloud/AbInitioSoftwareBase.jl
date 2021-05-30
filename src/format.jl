using Configurations: @option

export FormatConfig

@option mutable struct FormatConfig
    delimiter::String
    newline::String
    indent::String
    float::String
    int::String
    bool::String
end
