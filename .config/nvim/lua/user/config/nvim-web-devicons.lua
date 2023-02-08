local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-web-devicons"

function M.setup(...)
    if untils.check_require("nvim-web-devicons") == false then
        return
    end

    require("nvim-web-devicons").setup {
        color_icons = true;
        default = true;
    }
end

return M
