module Commands

using Compat: addenv
using Preferences: @load_preference, @set_preferences!

export Mpiexec

get_path() = @load_preference("mpiexec path", "mpiexec")

function set_path(path::String)
    @assert ispath(path)
    @set_preferences!("mpiexec path" => path)
end

# See https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php & https://www.mpich.org/static/docs/v3.1/www1/mpiexec.html
const SHORT_OPTIONS = (
    # Open MPI options
    "h",
    "q",
    "v",
    "v",
    "n",
    "h",
    "c",
    "n",
    "np",
    "rf",
    "s",
    "wd",
    "wdir",
    "x",
    "am",
    "cf",
    "d",
    # MPICH options
    "f",
    "l",
)
const LONG_OPTIONS = (
    # Open MPI options
    "help",
    "quiet",
    "verbose",
    "version",
    "display-map",
    "display-allocation",
    "output-proctable",
    "dvm",
    "max-vm-size",
    "novm",
    "hnp",
    "host",
    "hostfile",
    "default-hostfile",
    "machinefile",
    "cpu-set",
    "npersocket",
    "npernode",
    "pernode",
    "map-by",
    "bycore",
    "byslot",
    "nolocal",
    "nooversubscribe",
    "oversubscribe",
    "bynode",
    "cpu-list",
    "rank-by",
    "bind-to",
    "cpus-per-proc",
    "cpus-per-rank",
    "bind-to-core",
    "bind-to-socket",
    "report-bindings",
    "rankfile",
    "output-filename",
    "stdin",
    "merge-stderr-to-stdout",
    "tag-output",
    "timestamp-output",
    "xml",
    "xml-file",
    "xterm",
    "path",
    "prefix",
    "noprefix",
    "preload-binary",
    "preload-files",
    "set-cwd-to-session-dir",
    "gmca",
    "mca",
    "tune",
    "debug",
    "get-stack-traces",
    "debugger",
    "timeout",
    "tv",
    "allow-run-as-root",
    "app",
    "cartofile",
    "continuous",
    "disable-recovery",
    "do-not-launch",
    "do-not-resolve",
    "enable-recovery",
    "index-argv-by-rank",
    "leave-session-attached",
    "max-restarts",
    "ompi-server",
    "personality",
    "ppr",
    "report-child-jobs-separately",
    "report-events",
    "report-pid",
    "report-uri",
    "show-progress",
    "terminate",
    "use-hwthread-cpus",
    "use-regexp",
    "debug-devel",
    "debug-daemons",
    "debug-daemons-file",
    "display-devel-allocation",
    "display-devel-map",
    "display-diffable-map",
    "display-topo",
    "launch-agent",
    "report-state-on-timeout",
    # MPICH options
    "arch",
    "file",
    "soft",
    "configfile",
)

struct Mpiexec
    path::String
    env::Tuple
    options::Iterators.Pairs
end
Mpiexec(path, env...; options...) = Mpiexec(path, env, options)

function (mpiexec::Mpiexec)(exec...)
    args = [mpiexec.path]
    for (arg, val) in mpiexec.options
        if arg in (:env, :genv, :envlist, :genvlist)
            throw(ArgumentError("Please treat `$arg` as a positional argument `env`."))
        end
        _pusharg!(args, string(arg), val)
    end
    push!(args, exec...)
    cmd = Cmd(args)
    return addenv(cmd, mpiexec.env...)
end

function _pusharg!(args, arg, val)
    arg = replace(arg, '_' => '-')
    option = (arg in LONG_OPTIONS ? "--" : '-') * arg
    if val isa AbstractVector{<:AbstractString}
        join(val, ',')
        return push!(args, option, val)
    elseif val isa Bool  # flag
        return push!(args, option)
    elseif val isa Pair
        return push!(args, option, string(val.first), string(val.second))
    elseif val isa AbstractVector{<:Pair} || val isa AbstractDict
        for v in val
            push!(args, option, string(v.first), string(v.second))
        end
    else
        return push!(args, option, string(val))
    end
end

end
