using QuantumESPRESSOCommands: pw, set_path
using Test

@testset "Test `pw`" begin
    @test pw("scf.in", "scf.out"; np = 8, nimage = 4, npool = 2).cmd.cmd.exec ==
          ["mpiexec", "-np", "8", "pw.x", "-nimage", "4", "-npool", "2"]
    @test pw("/home/test/ph.in", "/home/test/ph.out").cmd.cmd.dir == "/home/test"
end

@testset "Test `set_path`" begin
    get_path("pw") == "pw.x"
    touch("pw2.x")
    set_path("pw", "pw2.x")
    @test pw("scf.in", "scf.out"; np = 8).cmd.cmd.exec == ["mpiexec", "-np", "8", "pw2.x"]
end
