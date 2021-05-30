using Configurations: @option

export FormatConfig

"""
    FormatConfig(delimiter, newline, indent, float, int, bool)

Specify the formatting options of an `Input` or part of an `Input`.

# Arguments
- `delimiter::String`: the delimiter between objects. We suggest `" "`.
- `newline::String`: the line terminator. Unix systems and macOS consider '\n' as a line terminator, while Windows supports '\r\n'. We suggest `"\n"`.
- `indent::String`: the empty spaces at the beginning of a line. We suggest `' '^4`.
- `float::String`: the format specification for `AbstractFloat`.
- `int::String`: the format specification for `Integer`s.
- `bool::String`: the format specification for `Bool`s. For Fortran software, it could be `".%s."`.
"""
@option mutable struct FormatConfig
    delimiter::String
    newline::String
    indent::String
    float::String
    int::String
    bool::String
end
