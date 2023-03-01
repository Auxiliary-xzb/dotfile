local alias = require("user.completion.snippets")

local M = {}

M.filetype = "lua"

local function get_plugin_config_template()
    return alias.s("plugin", {
        alias.t({ "local untils = require(\"user.untils\")", "" }),
        alias.t({ "", "local M = {}", "" }),
        alias.t({ "", "M.plugin_name = \"" }), alias.i(1), alias.t({ "\"", "" }),
        alias.t({ "", "function M.setup(...)" }),
        alias.t({ "", "    if untils.check_require(M.plugin_name) == false then" }),
        alias.t({ "", "        return" }),
        alias.t({ "", "    end", "", "" }),
        alias.i(2),
        alias.t({ "", "end", "" }),
        alias.t({ "", "return M" }),
    })
end

function M.setup(...)
    alias.ls.add_snippets(M.filetype, { get_plugin_config_template(), })
end

return M
