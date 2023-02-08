local untils = require("user.untils")

local M = {}

M.plugin_name = "indent-blankline"

function M.setup(...)
    if untils.check_require("indent_blankline") == false then
        return
    end

    vim.opt.list = true
    vim.opt.listchars:append "space:⋅"
    -- vim.opt.listchars:append "eol:↴"

    require("indent_blankline").setup({
        theme = vim.g.colors_name,

        -- specifies the character to be used as indent char
        char = "┆",

        -- turn plugin off when nolist is set
        disable_with_nolist = true,

        -- displays the end of line character set by listchars
        show_end_of_line = true,
    })
end

return M
