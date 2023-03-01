local untils = require("user.untils")

M = {}

M.plugin_name = "nvim-autopairs"

function M.setup(...)
    if untils.check_require(M.plugin_name) == false then
        return
    end

    require(M.plugin_name).setup({})
    local cmp = require("cmp")
    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
end

return M
