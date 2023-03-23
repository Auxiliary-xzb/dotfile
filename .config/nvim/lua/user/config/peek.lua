local untils = require("user.untils")

local M = {}

M.plugin_name = "peek"

function M.setup(...)
    if untils.check_require(M.plugin_name) == false then
        return
    end

    -- https://github.com/toppair/peek.nvim/issues/28#issuecomment-1474657982
    -- 解决调用PeekOpen时出错的问题
    require(M.plugin_name).setup({
        auto_load = true, -- whether to automatically load preview when
        -- entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete
        syntax = true, -- enable syntax highlighting, affects performance
        theme = 'dark', -- 'dark' or 'light'
        update_on_change = true,
        app = 'webview', -- 'webview', 'browser', string or a table of strings
        -- explained below

        filetype = { 'markdown' }, -- list of filetypes to recognize as markdown
        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this
        -- amount of bytes in size
        throttle_time = 'auto', -- minimum amount of time in milliseconds
        -- that has to pass before starting new render
    })

    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
end

return M
