module("oracle", package.seeall)

require("oracle.help")
require("oracle.utils")

--- Entry point of the module oracle
--@param args A table of parameters
--@param aproject An existing project
function oracle:oracle_launch(args, aproject)
    local help = oracle:init_help()
    -- Print version if -v or --version are passed in parameters
    if args.v == true or args.version == true then
        help:print_version(false, args.verbose)
    end

    -- Print help if -h or --help are passed in parameters
    if args.h == true or args.help == true then
        help:print_help(false, args.verbose)
    end

    -- If help or version have been displayed, exit
    if
        args.h == true
        or args.help == true
        or args.v == true
        or args.version == true
    then
        os.exit(0)
    end

    -- Check if a binary was given
    if not args.bin then
        help:print_help(false, args.verbose)
        os.exit(1)
    end

    -- Run cqa on the binary
    -- TODO: select another loop
    -- FIXME: do not spawn a shell (missing lua doc)
    local cqa_output = "out.csv"
    local ret = os.execute(
        args._maqao_
            .. " cqa "
            .. args.bin
            .. " loop=0 conf=all output-path="
            .. cqa_output
    )

    -- Error handling
    if ret ~= 0 then
        print("Failed to run maqao cqa.")
        os.exit(2)
    end

    -- Read the output of cqa
    local infos = oracle:csv_to_table(cqa_output)

    -- Debug: print the array
    if args.dgb then
        for key, value in pairs(infos) do
            print(key .. " => " .. value)
        end
    end

    -- Print vectorization and unroll info
    local target_keys = {
        "Vec. eff. ratio (%): all",
        "Unroll info (src loop)",
        "Unroll factor",
    }
    for _, key in ipairs(target_keys) do
        print(key .. ": " .. infos[key])
    end

    -- Clean-up
    -- TODO: no clean-up flag
    os.execute("rm " .. cqa_output)

    -- Our check
    -- Create a project and load a given binary
    local proj = project.new("unroll_check_" .. args.bin)
    -- arg[1] contains the first command line parameter
    local bin = proj:load(args.bin, 0)
    local oracle_unroll_factor = oracle:get_loop_inc(bin, 0)
    print("Oracle unroll factor: " .. tostring(oracle_unroll_factor))
end
