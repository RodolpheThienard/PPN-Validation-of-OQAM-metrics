-- Monte carlo (mpi version) stripped config file
experiment_name = "monte carlo mpi"
executable = "./monte_carlo_mpi"
-- Change this according to your CPU
problem_size = 6e8
run_command = "<executable> " .. tostring(problem_size)
mpi_command = "mpirun -np <number_processes>"
envv_I_MPI_PIN = "yes"
envv_I_MPI_PIN_ORDER = "spread"
number_processes = 1
base_run_name = "1 process"

-- Function that creates the table of a given thread processes
function multiruns_params_entrie(n)
    return {
        run_command = "<executable> " .. tostring(problem_size * n),
        mpi_command = "mpirun -np <number_processes>",
        number_processes = n,
        name = tostring(n) .. " processes",
    }
end

-- Change this according to your CPU
-- You may want to adapt the number of processes
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
