local untils = require("user.untils")

local M = {}

M.plugin_name = "luasnip"

function M.setup(...)
    if untils.check_require("luasnip") == false then
        return
    end

    -- FIXME: 启用自己注释的snippets会产生按下tab时当前焦点自动跳转到最后一行的BUG
    --local snip_dir = vim.fn.stdpath("config") .. "/lua/user/completion/snippets"
    --for _, file_name in ipairs(vim.fn.readdir(snip_dir)) do
    --    if file_name ~= "init.lua" then
    --        require("user.completion.snippets." .. string.gsub(file_name, "%.lua", "")).setup()
    --    end
    --end
end

return M
