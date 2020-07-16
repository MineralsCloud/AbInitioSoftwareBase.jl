module CLI

export MpiLauncher

"""
    MpiLauncher(n; bin = "mpiexec", host = [], hostfile = "", args = [])

Represent the `mpiexec` or `mpirun` executable. Must be combined with an actual command.

Type `?MpiCmd.host` to see the documentation of the `host` parameter, and so on.
"""
struct MpiLauncher
    "Specify the number of processes to use."
    n::UInt
    "Path to the `mpiexec` or `mpirun` executable."
    bin
    "List of hosts on which to invoke processes."
    host::Vector
    "Provide a hostfile to use."
    hostfile
    "Other args to be specified. Must be a `Vector` of `Pair`s."
    args::Vector
end
MpiLauncher(n; bin = "mpiexec", host = String[], hostfile = "", args = Pair[]) =
    MpiLauncher(n, bin, host, hostfile, args)

end
