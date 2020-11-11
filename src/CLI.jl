module CLI

export Mpiexec

"""
    Mpiexec(np; bin = "mpiexec", host = [], hostfile = "", args = Pair[])

Represent the `mpiexec` or `mpirun` executable. Must be combined with an actual command.

Type `?Mpiexec.host` to see the documentation of the `host` parameter, and so on.
"""
struct Mpiexec
    "Specify the number of processes to use."
    np::UInt
    "Path to the `mpiexec` or `mpirun` executable."
    bin::Any
    "List of hosts on which to invoke processes."
    host::Vector
    "Provide a hostfile to use."
    hostfile::Any
    "Other args to be specified. Must be a `Vector` of `Pair`s."
    args::Vector
end
Mpiexec(np; bin = "mpiexec", host = String[], hostfile = "", args = Pair[]) =
    Mpiexec(np, bin, host, hostfile, args)

end
