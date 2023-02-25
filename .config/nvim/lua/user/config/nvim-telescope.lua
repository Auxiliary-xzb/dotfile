local untils = require("user.untils")

local M = {}

M.plugin_name = "telescope"

function M.setup(...)
    if untils.check_require("telescope") == false then
        return
    end

    require("telescope").setup()
end

return M
