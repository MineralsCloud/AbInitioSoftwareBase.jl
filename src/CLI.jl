module CLI

export MpiExec

"""
    MpiExec(np; bin = "mpiexec", host = [], hostfile = "", args = Pair[])

Represent the `mpiexec` or `mpirun` executable. Must be combined with an actual command.

Type `?MpiExec.host` to see the documentation of the `host` parameter, and so on.
"""
struct MpiExec
    "Specify the number of processes to use."
    np::UInt
    "Path to the `mpiexec` or `mpirun` executable."
    bin
    "List of hosts on which to invoke processes."
    host::Vector
    "Provide a hostfile to use."
    hostfile
    "Other args to be specified. Must be a `Vector` of `Pair`s."
    args::Vector
end
MpiExec(np; bin = "mpiexec", host = String[], hostfile = "", args = Pair[]) =
    MpiExec(np, bin, host, hostfile, args)

end
