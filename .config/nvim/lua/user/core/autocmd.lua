-- commActionGroup --
local commActionGroup = vim.api.nvim_create_augroup("CommAction", { clear = true, })
vim.api.nvim_create_autocmd("BufWrite", {
    pattern = "*",
    group = commActionGroup,
    callback = function ()
        local currentPosition = vim.api.nvim_win_get_cursor(0)
        -- 删除行尾空白符
        vim.cmd("silent %s/\\s*$//g")
        -- 替换Tab为空格
        vim.cmd("silent %retab!")
        vim.api.nvim_win_set_cursor(0, currentPosition)
    end,
})

-- fileTypeGroup --
local fileTypeGroup = vim.api.nvim_create_augroup("FileTypeDetect", { clear = true, })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    group = fileTypeGroup,
    callback = function (info)
        -- 按照语法折叠，且默认展开所有折叠。
        local winid = vim.api.nvim_get_current_win()
        vim.wo[winid].foldmethod = "syntax"
        vim.wo[winid].foldlevel = 999

        -- tab的宽度为2
        vim.api.nvim_buf_set_option(info.buf, "softtabstop", 2)
        vim.api.nvim_buf_set_option(info.buf, "shiftwidth", 2)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "text",
    group = fileTypeGroup,
    callback = function (info)
        -- 关闭所有的自动换行
        vim.api.nvim_buf_set_option(info.buf, "autoindent", false)
        vim.api.nvim_buf_set_option(info.buf, "smartindent", false)
        vim.api.nvim_buf_set_option(info.buf, "cindent", false)
        vim.api.nvim_buf_set_option(info.buf, "indentexpr", false)
    end,
})

-- TODO: 将help放置在独立的window/tab中打开。
--  vim.api.nvim_create_autocmd("FileType", {
--      pattern = "help",
--      group = fileTypeGroup,
--      callback = function (info)
--
--      end,
--  })
