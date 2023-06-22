using AbInitioSoftwareBase.Commands

@testset "Test `Mpiexec`" begin
    mpiexec = Mpiexec(
        "mpiexec",
        "TMPDIR" => "./",
        "OMP_NUM_THREADS" => 1;
        np=16,
        map_by="core",
        use_regexp=true,
        mca=["btl_openib_if_include" => "mlx5_2:1", "btl" => "openib,self,vader"],
    )
    cmd = mpiexec("pw.x", "-inp", "scf.in")
    @test cmd.exec == [
        "mpiexec",
        "-np",
        "16",
        "--map-by",
        "core",
        "--use-regexp",
        "--mca",
        "btl_openib_if_include",
        "mlx5_2:1",
        "--mca",
        "btl",
        "openib,self,vader",
        "pw.x",
        "-inp",
        "scf.in",
    ]
    @test "TMPDIR=./" in cmd.env
    @test "OMP_NUM_THREADS=1" in cmd.env
    @test_throws MethodError Mpiexec(; env=["TMPDIR" => "./", "OMP_NUM_THREADS" => 1])
end
