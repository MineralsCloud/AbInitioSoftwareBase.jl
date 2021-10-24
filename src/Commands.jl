module Commands

using Compat: addenv
using Configurations: from_kwargs, @option
@static if VERSION >= v"1.6"
    using Preferences: @load_preference
end

export mpiexec

@static if VERSION >= v"1.6"
    const mpiexec_path = @load_preference("mpiexec path", "mpiexec")
else
    const mpiexec_path = "mpiexec"
end

"Represent the configurations of a command."
abstract type CommandConfig end

# See https://www.open-mpi.org/doc/v3.0/man1/mpiexec.1.php
const SHORT_OPTIONS = (
    # Open MPI options
    :h,
    :q,
    :v,
    :V,
    :N,
    :H,
    :c,
    :n,
    :np,
    :rf,
    :s,
    :wd,
    :wdir,
    :x,
    :am,
    :cf,
    :d,
    # MPICH options
)
const LONG_OPTIONS = (
    # Open MPI options
    :help,
    :quiet,
    :verbose,
    :version,
    :display_map,
    :display_allocation,
    :output_proctable,
    :dvm,
    :max_vm_size,
    :novm,
    :hnp,
    :host,
    :hostfile,
    :default_hostfile,
    :machinefile,
    :cpu_set,
    :npersocket,
    :npernode,
    :pernode,
    :map_by,
    :bycore,
    :byslot,
    :nolocal,
    :nooversubscribe,
    :oversubscribe,
    :bynode,
    :cpu_list,
    :rank_by,
    :bind_to,
    :cpus_per_proc,
    :cpus_per_rank,
    :bind_to_core,
    :bind_to_socket,
    :report_bindings,
    :rankfile,
    :output_filename,
    :stdin,
    :merge_stderr_to_stdout,
    :tag_output,
    :timestamp_output,
    :xml,
    :xml_file,
    :xterm,
    :path,
    :prefix,
    :noprefix,
    :preload_binary,
    :preload_files,
    :set_cwd_to_session_dir,
    :gmca,
    :mca,
    :tune,
    :debug,
    :get_stack_traces,
    :debugger,
    :timeout,
    :tv,
    :allow_run_as_root,
    :app,
    :cartofile,
    :continuous,
    :disable_recovery,
    :do_not_launch,
    :do_not_resolve,
    :enable_recovery,
    :index_argv_by_rank,
    :leave_session_attached,
    :max_restarts,
    :ompi_server,
    :personality,
    :ppr,
    :report_child_jobs_separately,
    :report_events,
    :report_pid,
    :report_uri,
    :show_progress,
    :terminate,
    :use_hwthread_cpus,
    :use_regexp,
    :debug_devel,
    :debug_daemons,
    :debug_daemons_file,
    :display_devel_allocation,
    :display_devel_map,
    :display_diffable_map,
    :display_topo,
    :launch_agent,
    :report_state_on_timeout,
    # MPICH options
    :arch,
)

"""
    mpiexec(env = Pair{String,String}[]; kwargs...)

Generate a function from `kwargs` and `env`.
"""
function mpiexec(env = Pair{String,String}[]; kwargs...)
    args = [mpiexec_path]
    for (arg, val) in kwargs
        _pusharg!(args, string(arg), val)
    end
    return function (exec)
        append!(args, exec)
        cmd = Cmd(args)
        return addenv(addenv(cmd), env...)
    end
end

function _pusharg!(args, arg, val)
    arg = replace(arg, '_' => '-')
    option = (arg in LONG_OPTIONS ? "--" : '-') * arg
    val = if val isa AbstractVector{<:AbstractString}
        join(val, ',')
    elseif val isa Pair
        join(val, ' ')
    elseif val isa AbstractVector{<:Pair} || val isa AbstractDict
        for v in val
            push!(args, option, join(v, ' '))
        end
        return args
    else
        string(val)
    end
    return push!(args, option, val)
end

end
