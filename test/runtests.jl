using AbInitioSoftwareBase.Commands: MpiexecConfig
using QuantumESPRESSOCommands: ParallelizationFlags, PwxConfig, PhxConfig, makecmd
using Test

@testset "QuantumESPRESSOCommands.jl" begin
    @test makecmd(
        "scf.in",
        "scf.out";
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(),
    ).cmd.cmd.exec[2:end] == ["-np", "8", "pw.x"]
    @test makecmd(
        "scf.in",
        "scf.out";
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(; options = ParallelizationFlags(; nimage = 4)),
    ).cmd.cmd.exec[2:end] == ["-np", "8", "pw.x", "-nimage", "4"]
    @test makecmd(
        "/home/test/ph.in",
        "/home/test/ph.out";
        main = PhxConfig(),
    ).cmd.cmd.dir == "/home/test"
end
