@testset "`load` and `save`" begin
    dict = Dict(
        "a" => 1,
        "b" => 1.0e4,
        "c" => [1, 2, "3", "4.0"],
        "4" => true,
        "5.0" => "Hello",
    )
    @testset "Save to YAML" begin
        bench = Dict(
            5.0 => "Hello",
            4 => true,
            "c" => Any[1, 2, "3", "4.0"],
            "b" => 10000.0,
            "a" => 1,
        )
        file = "test.yaml"
        save(file, dict)
        @test load(file) == bench
        file = "test.yml"
        save(file, dict)
        @test load(file) == bench
        save("mixed.YaMl", dict)
        @test load("mixed.YaMl") == bench
    end
    @testset "Save to JSON" begin
        file = "test.json"
        save(file, dict)
        @test load(file) == dict
        save("mixed.Json", dict)
        @test load("mixed.Json") == dict
    end
    @testset "Save to TOML" begin
        file = "test.toml"
        save(file, dict)
        @test load(file) == dict
        save("mixed.ToMl", dict)
        @test load("mixed.ToMl") == dict
    end
    @testset "Other extensions" begin
        @test_throws MethodError save("x.aml", dict)
        @test_throws MethodError save("x.jon", dict)
        @test_throws MethodError save("x.Tml", dict)
    end
end
