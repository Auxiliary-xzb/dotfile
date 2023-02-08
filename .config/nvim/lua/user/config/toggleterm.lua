local untils = require("user.untils")

local M = {}

M.plugin_name = "toggleterm"

function M.setup(...)
    if untils.check_require("toggleterm") == false then
        return
    end

    require("toggleterm").setup({
        -- when neovim changes it current the terminal will changes
        -- it's own when next it's opened
        autochdir = true,

        -- start with insert mode
        start_in_insert = true,

        -- whether or not the open mapping applies in insert mode
        insert_mapping = true,

        -- open in float
        direction = "float",

        -- theme
        theme = vim.g.colors_name
    })
end

return M

