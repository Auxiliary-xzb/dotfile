local untils = require("user.untils")

local M = {}

function M.setup(...)
    if untils.check_require("github-theme") == false then
        return
    end

    require("github-theme").setup({
        theme_style = "light",
        comment_style = "NONE",
        function_style = "NONE",
        keyword_style = "NONE",
    })
end

return M
