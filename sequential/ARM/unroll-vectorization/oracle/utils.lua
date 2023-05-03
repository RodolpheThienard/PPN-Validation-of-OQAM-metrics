module("oracle.utils", package.seeall)

--- Convert a csv to a lua table
--@param filename A string that is the path to the file
function oracle:csv_to_table(filename)
    local ret = {}
    local keys = {}
    local values = {}

    -- Read the csv
    local csv_file = io.open(filename, "r")
    local keys_str = csv_file:read("*line")
    local values_str = csv_file:read("*line")
    csv_file:close()

    -- Store keys
    for key in string.gmatch(keys_str, "([^;]+)") do
        keys[#keys + 1] = key
    end

    -- Store values
    for value in string.gmatch(values_str, "([^;]+)") do
        -- Convert the value to a number if it is numeric
        values[#values + 1] = tonumber(value) or value
    end

    -- Merge keys and values
    for i, key in ipairs(keys) do
        ret[key] = values[i]
    end

    return ret
end

--- Return the increment of a loop
--@param binary the binary to check
--@param loop_id the id of the loop to analyze
function oracle:get_loop_inc(binary, loop_id)
    local unroll_factor = nil

    for f in binary:functions() do
        for l in f:loops() do
            if tonumber(l:get_id()) == loop_id then
                for b in l:blocks() do
                    for i in b:instructions() do
                        if i:is_add_sub() then
                            local op = i:get_oprnd_str(0)
                            if string.sub(op, 1, 1) == "$" then
                                unroll_factor = math.min(
                                    unroll_factor or math.huge,
                                    tonumber(string.sub(op, 2, string.len(op)))
                                )
                            end
                        end
                    end
                end
                break
            end
        end
    end

    return unroll_factor or 0
end
