local untils = require("user.untils")

local M = {}

function M.setup(...)
    if untils.check_require("tokyonight") == false then
        return
    end

    vim.cmd("colorscheme tokyonight-storm")
end

return M
