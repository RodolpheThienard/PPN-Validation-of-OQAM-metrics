-- Monte carlo (omp version) stripped config file
experiment_name = "monte carlo hybrid"
executable = "./monte_carlo_hybrid"
-- Change this according to your CPU
problem_size = 5e9
run_command = "<executable> " .. tostring(problem_size)
mpi_command = "mpirun -np <number_processes>"
envv_OMP_NUM_THREADS = "1"
base_run_name = "1 proc x 1 thread"

-- Function that creates the table
function multiruns_params_entrie(p, t)
    return {
        mpi_command = "mpirun -bind-to none -np <number_processes>",
        number_processes = p,
        name = tostring(p) .. " proc x " .. tostring(t) .. " threads",
        envv_OMP_NUM_THREADS = t,
    }
end

-- Change this according to your CPU
-- You may want to adapt the number of procs/threads
-- in function of your CPU
multiruns_params = {
    multiruns_params_entrie(1, 2),
    multiruns_params_entrie(2, 2),
    multiruns_params_entrie(3, 2),
    multiruns_params_entrie(4, 2),
}
