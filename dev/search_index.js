var documenterSearchIndex = {"docs":
[{"location":"api/Commands/#Commands-module","page":"Commands module","title":"Commands module","text":"","category":"section"},{"location":"api/Commands/","page":"Commands module","title":"Commands module","text":"CurrentModule = AbInitioSoftwareBase.Commands","category":"page"},{"location":"api/Commands/#Public-interfaces","page":"Commands module","title":"Public interfaces","text":"","category":"section"},{"location":"api/Commands/","page":"Commands module","title":"Commands module","text":"CommandConfig\nMpiexecConfig","category":"page"},{"location":"api/Commands/#AbInitioSoftwareBase.Commands.CommandConfig","page":"Commands module","title":"AbInitioSoftwareBase.Commands.CommandConfig","text":"Represent the configurations of a command.\n\n\n\n\n\n","category":"type"},{"location":"api/Commands/#AbInitioSoftwareBase.Commands.MpiexecConfig","page":"Commands module","title":"AbInitioSoftwareBase.Commands.MpiexecConfig","text":"MpiexecConfig(; exe=\"mpiexec\", np=0, options=Dict())\n\nRepresent an mpiexec executable.\n\nArguments\n\nexe::String=\"mpiexec\": the path to the executable.\nnp::UInt=0: the number of processes used. If np is zero, it means no parallelization is performed.\noptions::Dict{String,Any}=Dict(): the options of mpiexec. See \"mpiexec(1) man page\".\n\n\n\n\n\n","category":"type"},{"location":"api/Inputs/#Inputs-module","page":"Inputs module","title":"Inputs module","text":"","category":"section"},{"location":"api/Inputs/","page":"Inputs module","title":"Inputs module","text":"CurrentModule = AbInitioSoftwareBase.Inputs","category":"page"},{"location":"api/Inputs/#Public-interfaces","page":"Inputs module","title":"Public interfaces","text":"","category":"section"},{"location":"api/Inputs/","page":"Inputs module","title":"Inputs module","text":"Input\nInputEntry\nNamelist\nCard\ngroupname\nasstring\nwritetxt\nFormatConfig","category":"page"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.Input","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.Input","text":"Input\n\nAn abstract type representing an input object of ab initio software. All other input types should subtype Input.\n\n\n\n\n\n","category":"type"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.InputEntry","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.InputEntry","text":"InputEntry\n\nRepresent any component of an Input. The fields of an Input should all be either InputEntry or Nothing (no value provided).\n\n\n\n\n\n","category":"type"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.Namelist","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.Namelist","text":"Namelist <: InputEntry\n\nRepresent a component of an Input, a basic Fortran data structure.\n\n\n\n\n\n","category":"type"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.Card","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.Card","text":"Card <: InputEntry\n\nRepresent CAR or cards of an Input in VASP, Quantum ESPRESSO, etc.\n\n\n\n\n\n","category":"type"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.groupname","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.groupname","text":"groupname(x::InputEntry)\n\nGet the group name of an InputEntry.\n\nThe definition groupname(x) = groupname(typeof(x)) is provided for convenience so that instances can be passed instead of types.\n\n\n\n\n\n","category":"function"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.asstring","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.asstring","text":"asstring(object::Union{Input,InputEntry}, config::FormatConfig)\nasstring(object::Union{Input,InputEntry}; kwargs...)\n\nReturn a string representing a qualified Input or part of an Input, with formatting arguments FormatConfig or kwargs.\n\nSee also: FormatConfig\n\n\n\n\n\n","category":"function"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.writetxt","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.writetxt","text":"writeinput(io::IO, input::Input)\nwriteinput(file, input::Input)\n\nWrite an Input object to file or io using corresponding string format.\n\n\n\n\n\n","category":"function"},{"location":"api/Inputs/#AbInitioSoftwareBase.Inputs.FormatConfig","page":"Inputs module","title":"AbInitioSoftwareBase.Inputs.FormatConfig","text":"FormatConfig(delimiter, newline, indent, float, int, bool)\n\nSpecify the formatting options of an Input or part of an Input.\n\nArguments\n\ndelimiter::String: the delimiter between objects. We suggest \" \".\nnewline::String: the line terminator. Unix systems and macOS consider '\\n' as a line terminator, while Windows supports '\\r\\n'. We suggest \"\\n\".\nindent::String: the empty spaces at the beginning of a line. We suggest ' '^4.\nfloat::String: the format specification for AbstractFloat.\nint::String: the format specification for Integers.\nbool::String: the format specification for Bools. For Fortran software, it could be \".%s.\".\n\n\n\n\n\n","category":"type"},{"location":"api/AbInitioSoftwareBase/#AbInitioSoftwareBase-module","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase module","text":"","category":"section"},{"location":"api/AbInitioSoftwareBase/","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase module","text":"CurrentModule = AbInitioSoftwareBase","category":"page"},{"location":"api/AbInitioSoftwareBase/#Public-interfaces","page":"AbInitioSoftwareBase module","title":"Public interfaces","text":"","category":"section"},{"location":"api/AbInitioSoftwareBase/","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase module","text":"load\nloads\nsave\nof_format","category":"page"},{"location":"api/AbInitioSoftwareBase/#AbInitioSoftwareBase.load","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase.load","text":"load(file)\n\nLoad data from file to a Dict.\n\nBy now, YAML, JSON, and TOML formats are supported. The format is recognized by file extension.\n\n\n\n\n\n","category":"function"},{"location":"api/AbInitioSoftwareBase/#AbInitioSoftwareBase.loads","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase.loads","text":"loads(str, format)\n\nLoad data from str to a Dict. Allowed formats are \"yaml\", \"yml\", \"json\" and \"toml\".\n\n\n\n\n\n","category":"function"},{"location":"api/AbInitioSoftwareBase/#AbInitioSoftwareBase.save","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase.save","text":"save(file, data)\n\nSave data to file.\n\nBy now, YAML, JSON, and TOML formats are supported. The format is recognized by file extension.\n\nwarning: Warning\nAllowed data types can be referenced in JSON.jl documentation and YAML.jl documentation. For TOML format, only AbstractDict type is allowed.\n\n\n\n\n\n","category":"function"},{"location":"api/AbInitioSoftwareBase/#AbInitioSoftwareBase.of_format","page":"AbInitioSoftwareBase module","title":"AbInitioSoftwareBase.of_format","text":"of_format(to, from)\n\nConvert from to the format of to. Similar to oftype.\n\n\n\n\n\n","category":"function"},{"location":"develop/#How-to-develop-this-package-by-yourself","page":"Development","title":"How to develop this package by yourself","text":"","category":"section"},{"location":"develop/#Download-the-project","page":"Development","title":"Download the project","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Similar to section \"Installation\", run","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"julia> using Pkg\n\njulia> pkg\"dev AbInitioSoftwareBase\"","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"Then the package will be cloned to your local machine at a path. On macOS, by default is located at ~/.julia/dev/AbInitioSoftwareBase unless you modify the JULIA_DEPOT_PATH environment variable. (See Julia's official documentation on how to do this.) In the following text, we will call it PKGROOT.","category":"page"},{"location":"develop/#instantiating","page":"Development","title":"Instantiate the project","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Go to PKGROOT, start a new Julia session and run","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"julia> using Pkg; Pkg.instantiate()","category":"page"},{"location":"develop/#How-to-build-docs","page":"Development","title":"How to build docs","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"Usually, the up-to-state doc is available in here, but there are cases where users need to build the doc themselves.","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"After instantiating the project, go to PKGROOT, run (without the $ prompt)","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"$ julia --color=yes docs/make.jl","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"in your terminal. In a while a folder PKGROOT/docs/build will appear. Open PKGROOT/docs/build/index.html with your favorite browser and have fun!","category":"page"},{"location":"develop/#How-to-run-tests","page":"Development","title":"How to run tests","text":"","category":"section"},{"location":"develop/","page":"Development","title":"Development","text":"After instantiating the project, go to PKGROOT, run (without the $ prompt)","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"$ julia --color=yes test/runtests.jl","category":"page"},{"location":"develop/","page":"Development","title":"Development","text":"in your terminal.","category":"page"},{"location":"troubleshooting/#Troubleshooting","page":"Troubleshooting","title":"Troubleshooting","text":"","category":"section"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"This page collects some possible errors you may encounter and trick how to fix them.","category":"page"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"If you have additional tips, please submit a PR with suggestions.","category":"page"},{"location":"troubleshooting/#Installation-problems","page":"Troubleshooting","title":"Installation problems","text":"","category":"section"},{"location":"troubleshooting/#Cannot-find-the-Julia-executable","page":"Troubleshooting","title":"Cannot find the Julia executable","text":"","category":"section"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"Make sure you have Julia installed in your environment. Please download the latest stable Julia for your platform. If you are using macOS, the recommended way is to use Homebrew. If you do not want to install Homebrew or you are using other *nix that Julia supports, download the corresponding binaries. And then create a symbolic link /usr/local/bin/julia to the Julia executable. If /usr/local/bin/ is not in your $PATH, modify your .bashrc or .zshrc and export it to your $PATH. Some clusters, like Habanero, Comet already have Julia installed as a module, you may just module load julia to use it. If not, either install by yourself or contact your administrator.","category":"page"},{"location":"troubleshooting/#Loading-settings","page":"Troubleshooting","title":"Loading settings","text":"","category":"section"},{"location":"troubleshooting/#Error-parsing-YAML-files","page":"Troubleshooting","title":"Error parsing YAML files","text":"","category":"section"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"If you encounter","category":"page"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"ERROR: expected '<document start>' but found YAML.BlockMappingStartToken at nothing","category":"page"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"or","category":"page"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"ERROR: while scanning a simple key at line n, column 0: could not find expected ':' at line n+1, column 0","category":"page"},{"location":"troubleshooting/","page":"Troubleshooting","title":"Troubleshooting","text":"Check whether you have no space between the YAML key and its value like key:1 or key:some text, etc. To correct, change to key: 1, key: some text, etc. Otherwise check other YAML syntax you may have broken.","category":"page"},{"location":"install/#Installation","page":"Installation","title":"Installation","text":"","category":"section"},{"location":"install/","page":"Installation","title":"Installation","text":"To install this package, first, you need to install a julia executable from its official website. Version v1.0.0 and above is required. This package may not work on v0.7 and below.","category":"page"},{"location":"install/","page":"Installation","title":"Installation","text":"If you are using a Mac, and have Homebrew installed, open Terminal.app and type:","category":"page"},{"location":"install/","page":"Installation","title":"Installation","text":"brew cask install julia","category":"page"},{"location":"install/","page":"Installation","title":"Installation","text":"Now I am using macOS as a standard platform to explain the following steps:","category":"page"},{"location":"install/","page":"Installation","title":"Installation","text":"Open Terminal.app, and type julia to start a Julia session.\nRun\njulia> using Pkg; Pkg.update()\n\njulia> pkg\"add AbInitioSoftwareBase\"\nand wait for its finish.\nRun\njulia> using AbInitioSoftwareBase\nand have fun!\nWhile using, please keep this Julia session alive. Restarting may recompile the package and cost some time.","category":"page"},{"location":"install/#Reinstall","page":"Installation","title":"Reinstall","text":"","category":"section"},{"location":"install/","page":"Installation","title":"Installation","text":"In the same Julia session, run\njulia> Pkg.rm(\"AbInitioSoftwareBase\"); Pkg.gc()\nPress ctrl+d to quit the current session. Start a new Julia session and repeat the above steps.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = AbInitioSoftwareBase","category":"page"},{"location":"#AbInitioSoftwareBase","page":"Home","title":"AbInitioSoftwareBase","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"AbInitioSoftwareBase.jl is an interface package that defines some common API shared by some packages that represent different ab initio software like Quantum ESPRESSO, VASP, etc. The API will be extended in QuantumESPRESSOBase.jl, etc.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n    \"install.md\",\n    \"develop.md\",\n    \"troubleshooting.md\",\n    \"api/AbInitioSoftwareBase.md\",\n]\nDepth = 3","category":"page"},{"location":"#main-index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
