using AbInitioSoftwareBase.Commands: MpiexecConfig
using QuantumESPRESSOCommands: ParallelizationFlags, PwxConfig, makecmd
using Test

@testset "QuantumESPRESSOCommands.jl" begin
    @test makecmd(
        "scf.in";
        output = "scf.out",
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(),
        use_script = false,
    ).cmd.cmd.exec == ["mpiexec", "-n", "8", "pw.x", "-inp", "scf.in"]
    file = first(
        makecmd(
            "scf.in";
            output = "scf.out",
            mpi = MpiexecConfig(; np = 8),
            main = PwxConfig(),
            use_script = true,
        ).exec,
    )
    @test isfile(file)
    @test read(file, String) == "mpiexec -n 8 pw.x -inp 'scf.in' 1> 'scf.out' 2> 'scf.out'"
    @test makecmd(
        "scf.in";
        output = "scf.out",
        mpi = MpiexecConfig(; np = 8),
        main = PwxConfig(; options = ParallelizationFlags(; nimage = 8)),
        use_script = false,
    ).cmd.cmd.exec == ["mpiexec", "-n", "8", "pw.x", "-nimage", "8", "-inp", "scf.in"]
    file = first(
        makecmd(
            "scf.in";
            output = "scf.out",
            error = "scf.err",
            mpi = MpiexecConfig(),
            main = PwxConfig(; options = ParallelizationFlags(; nimage = 8)),
            use_script = true,
        ).exec,
    )
    @test isfile(file)
    @test read(file, String) == "pw.x -nimage 8 -inp 'scf.in' 1> 'scf.out' 2> 'scf.err'"
end
