module("oracle.help", package.seeall)

function oracle:init_help()
    local help = Help:new()
    help:set_name("oracle")
    help:set_usage("maqao module=oracle bin=<binary> [...]")
    help:set_description("Validation oracle for maqao")
    help:add_option(
        "bin",
        nil,
        "<binary>",
        false,
        "Select the binary to analyze"
    )
    Utils:load_common_help_options(help)
    return help
end
