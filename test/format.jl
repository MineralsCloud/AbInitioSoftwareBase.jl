using AbInitioSoftwareBase.Inputs: FormatConfig

@testset "Test `FormatConfig` is mutable" begin
    config = FormatConfig(;
        delimiter = " ",
        newline = "\n",
        indent = ' '^4,
        float = "%14.9f",
        int = "%5d",
        bool = ".%.",
    )
    config.newline = "\r\n"
    config.indent = ' '^5
    config.float = "%15.8f"
    @test config == FormatConfig(;
        delimiter = " ",
        newline = "\r\n",
        indent = ' '^5,
        float = "%15.8f",
        int = "%5d",
        bool = ".%.",
    )
    @test_throws MethodError config.delimiter = ' '
end
