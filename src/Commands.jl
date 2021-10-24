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
    mpiexec(config::MpiexecOptions)
    mpiexec(; kwargs...)

Construct an `mpiexec` from `kwargs` or an `MpiexecOptions`.
"""
function mpiexec(config::MpiexecOptions)
    args = [mpiexec_path]
    for field in (:f, :wdir, :configfile)
        if !isempty(getfield(config, field))
            push!(args, "-$field", getfield(config, field))
        end
    end
    if !isempty(getfield(config, :hosts))
        push!(args, "-hosts", join(getfield(config, :hosts), ','))
    end
    push!(args, "-np", string(config.np))
    return function (exec; kwargs...)
        append!(args, exec)
        cmd = Cmd(Cmd(args); kwargs...)
        return addenv(cmd, config.env)
    end
end
mpiexec(; kwargs...) = mpiexec(from_kwargs(MpiexecOptions; kwargs...))

end
