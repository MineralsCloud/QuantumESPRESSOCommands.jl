using AbInitioSoftwareBase.Commands: MpiexecConfig
using QuantumESPRESSOCommands: ParallelizationFlags, PwxConfig, makecmd
using Test

@testset "QuantumESPRESSOCommands.jl" begin
    @test makecmd(
        "scf.in";
        output = "scf.out",
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(),
    ).cmd.cmd.exec[2:end] == ["-np", "8", "pw.x"]
    @test makecmd(
        "scf.in";
        output = "scf.out",
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(; options = ParallelizationFlags(; nimage = 4)),
    ).cmd.cmd.exec[2:end] == ["-np", "8", "pw.x", "-nimage", "4"]
end
