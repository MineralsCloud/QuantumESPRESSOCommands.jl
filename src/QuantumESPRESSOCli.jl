module QuantumESPRESSOCli

using AbInitioSoftwareBase
using Comonicon: @cast, @main
using Configurations: from_kwargs, from_dict, @option

@option struct PwConfig
    exe::String = "pw.x"
    script_dest::String = ""
    chdir::Bool = true
    options::PwXConfig = PwXConfig()
end

@option struct PwXConfig
    nimage::UInt = 0
    npool::UInt = 0
    ntg::UInt = 0
    nyfft::UInt = 0
    nband::UInt = 0
    ndiag::UInt = 0
end

end
