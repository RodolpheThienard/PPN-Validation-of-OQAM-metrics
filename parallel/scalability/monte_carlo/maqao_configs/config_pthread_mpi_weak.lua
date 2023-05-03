-- Monte carlo (pthread mpi version) stripped config file
experiment_name = "monte carlo pthread mpi"
executable = "./monte_carlo_pthread_mpi"
-- Change this according to your CPU
problem_size = 6e8
run_command = "<executable> " .. tostring(problem_size) .. " 1"
mpi_command = "mpirun -np <number_processes>"
base_run_name = "1 proc x 1 thread"

-- Function that creates the table
function multiruns_params_entrie(p, t)
    return {
        mpi_command = "mpirun -bind-to none -np <number_processes>",
        number_processes = p,
        run_command = "<executable> "
            .. tostring(problem_size * p * t)
            .. " "
            .. tostring(t),
        name = tostring(p) .. " proc x " .. tostring(t) .. " threads",
    }
end

-- Change this according to your CPU
-- You may want to adapt the number of threads
-- in function of your CPU
multiruns_params = {
    multiruns_params_entrie(1, 2),
    multiruns_params_entrie(2, 2),
    multiruns_params_entrie(3, 2),
    multiruns_params_entrie(4, 2),
}
