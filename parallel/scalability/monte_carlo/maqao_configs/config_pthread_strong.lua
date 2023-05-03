-- Monte carlo (pthread version) stripped config file
experiment_name = "monte carlo pthread"
executable = "./monte_carlo_pthread"
-- Change this according to your CPU
problem_size = 5e9
run_command = "<executable> " .. tostring(problem_size) .. " 1"
base_run_name = "1 thread"

-- Function that creates the table of a given thread number
function multiruns_params_entrie(n)
    return {
        run_command = "<executable> "
            .. tostring(problem_size)
            .. " "
            .. tostring(n),
        name = tostring(n) .. " threads",
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
