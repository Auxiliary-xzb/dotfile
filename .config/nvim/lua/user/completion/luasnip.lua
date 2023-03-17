local untils = require("user.untils")

local M = {}

M.plugin_name = "luasnip"

-- https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1313310146
local function forget_snippet_when_leave_insert(lua_snippet)
    local sinnpetUnlinkGroup = vim.api.nvim_create_augroup("SnippetUnlink", { clear = true, })
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = { "s:n", "i:*" },
        group = sinnpetUnlinkGroup,
        desc = "Foget snippet when leaving insert mode, then <Tab> work normal",
        callback = function (info)
            if lua_snippet.session and lua_snippet.session.current_nodes[info.buf] and
                not lua_snippet.session.jump_active then
                lua_snippet.unlink_current()
            end
        end,
    })
end

function M.setup(...)
    if untils.check_require(M.plugin_name) == false then
        return
    end

    local lua_snippet = require(M.plugin_name)
    forget_snippet_when_leave_insert(lua_snippet)

    -- FIXME: 启用自己注释的snippets会产生按下tab时当前焦点自动跳转到最后一行的BUG
    --local snip_dir = vim.fn.stdpath("config") .. "/lua/user/completion/snippets"
    --for _, file_name in ipairs(vim.fn.readdir(snip_dir)) do
    --    if file_name ~= "init.lua" then
    --        require("user.completion.snippets." .. string.gsub(file_name, "%.lua", "")).setup()
    --    end
    --end
end

return M
