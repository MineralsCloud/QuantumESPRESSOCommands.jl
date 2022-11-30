var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API","title":"API","text":"CurrentModule = QuantumESPRESSOCommands","category":"page"},{"location":"api/#API","page":"API","title":"API","text":"","category":"section"},{"location":"api/#Public-interfaces","page":"API","title":"Public interfaces","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"pw\nph\nq2r\nmatdyn\ndynmat","category":"page"},{"location":"api/#QuantumESPRESSOCommands.pw","page":"API","title":"QuantumESPRESSOCommands.pw","text":"Run command pw.x.\n\nArguments\n\ninput: the path to the input file.\noutput: the path to the output file. If not specified, use a temporary path.\n\nOptions\n\n--np <n>: the number of processes used.\n--path <path>: the path to the executable.\n\nFlags\n\n--chdir: if true, change directory to where the input file is stored when running.\n\n\n\n\n\n","category":"function"},{"location":"api/#QuantumESPRESSOCommands.ph","page":"API","title":"QuantumESPRESSOCommands.ph","text":"Run command ph.x.\n\nArguments\n\ninput: the path to the input file.\noutput: the path to the output file. If not specified, use a temporary path.\n\nOptions\n\n--np <n>: the number of processes used.\n--path <path>: the path to the executable.\n\nFlags\n\n--chdir: if true, change directory to where the input file is stored when running.\n\n\n\n\n\n","category":"function"},{"location":"api/#QuantumESPRESSOCommands.q2r","page":"API","title":"QuantumESPRESSOCommands.q2r","text":"Run command q2r.x.\n\nArguments\n\ninput: the path to the input file.\noutput: the path to the output file. If not specified, use a temporary path.\n\nOptions\n\n--np <n>: the number of processes used.\n--path <path>: the path to the executable.\n\nFlags\n\n--chdir: if true, change directory to where the input file is stored when running.\n\n\n\n\n\n","category":"function"},{"location":"api/#QuantumESPRESSOCommands.matdyn","page":"API","title":"QuantumESPRESSOCommands.matdyn","text":"Run command matdyn.x.\n\nArguments\n\ninput: the path to the input file.\noutput: the path to the output file. If not specified, use a temporary path.\n\nOptions\n\n--np <n>: the number of processes used.\n--path <path>: the path to the executable.\n\nFlags\n\n--chdir: if true, change directory to where the input file is stored when running.\n\n\n\n\n\n","category":"function"},{"location":"api/#QuantumESPRESSOCommands.dynmat","page":"API","title":"QuantumESPRESSOCommands.dynmat","text":"Run command dynmat.x.\n\nArguments\n\ninput: the path to the input file.\noutput: the path to the output file. If not specified, use a temporary path.\n\nOptions\n\n--np <n>: the number of processes used.\n--path <path>: the path to the executable.\n\nFlags\n\n--chdir: if true, change directory to where the input file is stored when running.\n\n\n\n\n\n","category":"function"},{"location":"api/#Private-interfaces","page":"API","title":"Private interfaces","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"ParallelizationFlags\nPwxConfig\nPhxConfig\nQ2rxConfig\nMatdynxConfig\nDynmatxConfig\nmakecmd","category":"page"},{"location":"api/#QuantumESPRESSOCommands.ParallelizationFlags","page":"API","title":"QuantumESPRESSOCommands.ParallelizationFlags","text":"ParallelizationFlags(; nimage=0, npool=0, ntg=0, nyfft=0, nband=0, ndiag=0)\n\nConstruct parallelization flags of QuantumESPRESSO commands.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.PwxConfig","page":"API","title":"QuantumESPRESSOCommands.PwxConfig","text":"PwxConfig(; path, chdir, options)\n\nCreate configurations for pw.x.\n\nArguments\n\npath::String=\"pw.x\": the path to the executable.\nchdir::Bool=true: whether to change directory to where the input file is stored when running pw.x. If false, stay in the current directory.\noptions::ParallelizationFlags=ParallelizationFlags(): the parallelization flags of pw.x.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.PhxConfig","page":"API","title":"QuantumESPRESSOCommands.PhxConfig","text":"PhxConfig(; path, chdir, options)\n\nCreate configurations for ph.x.\n\nArguments\n\npath::String=\"ph.x\": the path to the executable.\nchdir::Bool=true: whether to change directory to where the input file is stored when running ph.x. If false, stay in the current directory.\noptions::ParallelizationFlags=ParallelizationFlags(): the parallelization flags of ph.x.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.Q2rxConfig","page":"API","title":"QuantumESPRESSOCommands.Q2rxConfig","text":"Q2rxConfig(; path, chdir, options)\n\nCreate configurations for q2r.x.\n\nArguments\n\npath::String=\"q2r.x\": the path to the executable.\nchdir::Bool=true: whether to change directory to where the input file is stored when running q2r.x. If false, stay in the current directory.\noptions::ParallelizationFlags=ParallelizationFlags(): the parallelization flags of q2r.x.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.MatdynxConfig","page":"API","title":"QuantumESPRESSOCommands.MatdynxConfig","text":"MatdynxConfig(; path, chdir, options)\n\nCreate configurations for matdyn.x.\n\nArguments\n\npath::String=\"matdyn.x\": the path to the executable.\nchdir::Bool=true: whether to change directory to where the input file is stored when running matdyn.x. If false, stay in the current directory.\noptions::ParallelizationFlags=ParallelizationFlags(): the parallelization flags of matdyn.x.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.DynmatxConfig","page":"API","title":"QuantumESPRESSOCommands.DynmatxConfig","text":"DynmatxConfig(; path, chdir, options)\n\nCreate configurations for dynmat.x.\n\nArguments\n\npath::String=\"dynmat.x\": the path to the executable.\nchdir::Bool=true: whether to change directory to where the input file is stored when running dynmat.x. If false, stay in the current directory.\noptions::ParallelizationFlags=ParallelizationFlags(): the parallelization flags of dynmat.x.\n\n\n\n\n\n","category":"type"},{"location":"api/#QuantumESPRESSOCommands.makecmd","page":"API","title":"QuantumESPRESSOCommands.makecmd","text":"makecmd(input, output; dir, mpi, main)\n\nMake commands for QuantumESPRESSO executables.\n\nArguments\n\ninput: the path to the input file.\noutput=mktemp(parentdir(input))[1]: the path to the output file.\nmpi=MpiexecConfig(): MPI configurations.\nmain: the configurations of the main executable.\n\n\n\n\n\n","category":"function"},{"location":"usage/#Usage","page":"Usage","title":"Usage","text":"","category":"section"},{"location":"usage/#How-to-run-commands","page":"Usage","title":"How to run commands","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"After installation, run in REPL","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"$ qe pw --help","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"to see allowed arguments and flags.","category":"page"},{"location":"usage/#How-to-write-a-config-file","page":"Usage","title":"How to write a config file","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"Configuration files can be written in three formats: TOML, JSON, and YAML. For example, write a TOML file in the following format","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"[mpi]\nnp = 8\n\n[pw]\nexe = \"/path/to/qe/bin/pw.x\"\nchdir = false\n\n    [pw.options]\n    nimage = 8\n    nyfft = 8\n\n[ph]\nexe = \"/path/to/qe/bin/ph.x\"\nchdir = false\n\n    [ph.options]\n    nimage = 8\n    nyfft = 8","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"You can use some format converters to convert between these three formats. Or you can use the AbInitioSoftwareBase.of_format function.","category":"page"},{"location":"develop/#How-to-contribute","page":"Development","title":"How to contribute","text":"","category":"section"},{"location":"develop/#Download-the-project","page":"Development","title":"Download the project","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Similar to section \"Installation\", run","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"julia> using Pkg\n\njulia> pkg\"dev QuantumESPRESSOCommands\"","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"in Julia REPL.","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"Then the package will be cloned to your local machine at a path. On macOS, by default is located at ~/.julia/dev/QuantumESPRESSOCommands unless you modify the JULIA_DEPOT_PATH environment variable. (See Julia's official documentation on how to do this.) In the following text, we will call it PKGROOT.","category":"page"},{"location":"develop/#instantiating","page":"Development","title":"Instantiate the project","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Go to PKGROOT, start a new Julia session and run","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"julia> using Pkg; Pkg.instantiate()","category":"page"},{"location":"develop/#How-to-build-docs","page":"Development","title":"How to build docs","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Usually, the up-to-state doc is available in here, but there are cases where users need to build the doc themselves.","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"After instantiating the project, go to PKGROOT, run (without the $ prompt)","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"$ julia --color=yes docs/make.jl","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"in your terminal. In a while a folder PKGROOT/docs/build will appear. Open PKGROOT/docs/build/index.html with your favorite browser and have fun!","category":"page"},{"location":"develop/#How-to-run-tests","page":"Development","title":"How to run tests","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"After instantiating the project, go to PKGROOT, run (without the $ prompt)","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"$ julia --color=yes test/runtests.jl","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"in your terminal.","category":"page"},{"location":"installation/#Installation","page":"Installation","title":"Installation","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"Pages = [\"installation.md\"]\nDepth = 5","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"To install this package, first, you need to install a julia executable from its official website. Version v1.0.0 and above is required. This package may not work on v0.7 and below.","category":"page"},{"location":"installation/#Installing-Julia","page":"Installation","title":"Installing Julia","text":"","category":"section"},{"location":"installation/#on-macOS","page":"Installation","title":"on macOS","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"If you are using a Mac, and have Homebrew installed, open Terminal.app and type:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"brew cask install julia","category":"page"},{"location":"installation/#on-Linux","page":"Installation","title":"on Linux","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"On Linux, the best way to install Julia is to use the Generic Linux Binaries. The JILL script does this for you. Just run","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"bash -ci \"$(curl -fsSL https://raw.githubusercontent.com/abelsiqueira/jill/master/jill.sh)\"","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"installs Julia into $HOME/.local/bin. This script also has a Python version, JILL.py. It can also be used on macOS.","category":"page"},{"location":"installation/#Installing-the-package","page":"Installation","title":"Installing the package","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"Now I am using macOS as a standard platform to explain the following steps:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"Open Terminal.app, and type julia to start a Julia session.\nRun\njulia> using Pkg; Pkg.update()\n\njulia> Pkg.add(\"QuantumESPRESSOCommands\")\nand wait for its finish.\nRun\njulia> using QuantumESPRESSOCommands\nand have fun!\nWhile using, please keep this Julia session alive. Restarting may recompile the package and cost some time.","category":"page"},{"location":"installation/#Reinstall","page":"Installation","title":"Reinstall","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"In the same Julia session, run\njulia> Pkg.rm(\"QuantumESPRESSOCommands\"); Pkg.gc()\nPress ctrl+d to quit the current session. Start a new Julia session and repeat the above steps.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = QuantumESPRESSOCommands","category":"page"},{"location":"#QuantumESPRESSOCommands","page":"Home","title":"QuantumESPRESSOCommands","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"QuantumESPRESSOCommands is a <a href=\"https://julialang.org\"><img src=\"https://julialang.org/assets/infra/julia.ico\" width=\"16em\">Julia Language</a> package. It is used to build some QuantumESPRESSO commands from Julia functions and types, and run from shell (scripts).","category":"page"},{"location":"#Command-Line-Interface","page":"Home","title":"Command Line Interface","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Add ~/.julia/bin to your PATH to enable command line interface. Or run QuantumESPRESSOCommands.comonicon_install_path() to install everything automatically.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Sometimes, you won't trigger the package build of Julia. You can install the command line interface manually via QuantumESPRESSOCommands.comonicon_install().","category":"page"},{"location":"#Completions","page":"Home","title":"Completions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"If you are using ZSH, you can enable the auto-completion by QuantumESPRESSOCommands.comonicon_install_path(). Or add the FPATH to your .zshrc","category":"page"},{"location":"","page":"Home","title":"Home","text":"export FPATH=\"$HOME/.julia/completions:$FPATH\"","category":"page"},{"location":"","page":"Home","title":"Home","text":"if you do not have oh-my-zsh installed, you need to add","category":"page"},{"location":"","page":"Home","title":"Home","text":"autoload -Uz compinit && compinit","category":"page"},{"location":"","page":"Home","title":"Home","text":"to your .zshrc as well.","category":"page"},{"location":"#Manual-Outline","page":"Home","title":"Manual Outline","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n    \"installation.md\",\n    \"develop.md\",\n    \"usage.md\",\n    \"api.md\",\n]\nDepth = 3","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
