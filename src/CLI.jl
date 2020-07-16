module CLI

export MpiExec

"""
    MpiCmd(n; host = "", arch = "", wdir = "", path = String[], file = "", configfile = "")

Represent the `mpiexec` command. Must be combined with an actual command.

Type `?MpiCmd.host` to see the documentation of the `host` parameter, and so on.
"""
struct MpiExec
    "Specify the number of processes to use."
    n::UInt
    "Name of host on which to run processes."
    host
    "Pick hosts with this architecture type."
    arch
    "Change directory to this one before running executable."
    wdir
    "Use this to find the executable."
    path
    "Implementation-defined specification file."
    file
    "A file containing specifications of host/program, one per line, with number as a comment indicator, e.g., the usual mpiexec input, but with \":\" replaced with a newline. That is, the `configfile` contains lines with `-soft`, `-n`, etc."
    configfile
end
MpiExec(
    n;
    host = "",
    arch = "",
    wdir = "",
    path = String[],
    file = "",
    configfile = "",
) = MpiExec(n, host, arch, wdir, path, file, configfile)
# The docs are from https://www.mpich.org/static/docs/v3.3/www1/mpiexec.html.

end
