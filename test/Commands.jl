using AbInitioSoftwareBase.Commands: Mpiexec

@testset "Test `Mpiexec` with short options" begin
    mpi = Mpiexec(
        "/usr/local/bin/mpiexec",
        "TMPDIR" => "/tmp",
        "PATH" => "/usr/local/bin";
        v=true,
        n=2,
    )
    cmd = mpi("myprogram")
    @test cmd.exec == ["/usr/local/bin/mpiexec", "-v", "-n", "2", "myprogram"]
    @test cmd.env == ["TMPDIR=/tmp", "PATH=/usr/local/bin"]
end

@testset "Test `Mpiexec` with long options" begin
    mpi = Mpiexec(
        "/usr/local/bin/mpiexec",
        "TMPDIR" => "/tmp",
        "PATH" => "/usr/local/bin";
        verbose=true,
        npersocket=2,
    )
    cmd = mpi("myprogram")
    @test cmd.exec ==
        ["/usr/local/bin/mpiexec", "--verbose", "--npersocket", "2", "myprogram"]
    @test cmd.env == ["TMPDIR=/tmp", "PATH=/usr/local/bin"]
end

@testset "Test `Mpiexec` with mixed options" begin
    mpi = Mpiexec(
        "/usr/local/bin/mpiexec",
        "TMPDIR" => "/tmp",
        "PATH" => "/usr/local/bin";
        v=true,
        npersocket=2,
    )
    cmd = mpi("myprogram")
    @test cmd.exec == ["/usr/local/bin/mpiexec", "-v", "--npersocket", "2", "myprogram"]
    @test cmd.env == ["TMPDIR=/tmp", "PATH=/usr/local/bin"]
end

@testset "Test `Mpiexec` with `pw.x`" begin
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
