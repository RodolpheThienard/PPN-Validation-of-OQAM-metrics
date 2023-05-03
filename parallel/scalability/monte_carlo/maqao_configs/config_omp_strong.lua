-- Monte carlo (omp version) stripped config file
experiment_name = "monte carlo omp"
executable = "./monte_carlo_omp"
-- Change this according to your CPU
problem_size = 5e9
run_command = "<executable> " .. tostring(problem_size)
envv_OMP_NUM_THREADS = "1"
envv_OMP_PROC_BIND = "spread"
base_run_name = "1 thread"

-- Function that creates the table of a given thread number
function multiruns_params_entrie(n)
    return {
        name = tostring(n) .. " threads",
        envv_OMP_NUM_THREADS = n,
    }
end

-- Change this according to your CPU
-- You may want to adapt the number of threads
-- in function of your CPU
multiruns_params = {
    multiruns_params_entrie(2),
    multiruns_params_entrie(3),
    multiruns_params_entrie(4),
    multiruns_params_entrie(5),
    multiruns_params_entrie(6),
    multiruns_params_entrie(7),
    multiruns_params_entrie(8),
}
