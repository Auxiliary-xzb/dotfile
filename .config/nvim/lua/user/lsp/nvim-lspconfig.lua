local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-lspconfig"

function M.setup(...)
    if untils.check_require("lspconfig") == false then
        return
    end

    -- https://github.com/hrsh7th/nvim-cmp/issues/1208
    -- 在原有的模式下会产生问题，当snippet出现时敲击Enter键却无法完成相应的选择项
    -- 的添加，而是清除了之前的所有输入。引发上述问题的关键在于为lsp-server配置
    -- capabilities。所有的capabilities的获取操作应该在setup所有的lsp-server之前。
    -- 所以这里直接放在所有的lsp-server的配置中(不能将capabilities放在函数里，否则
    -- 会出现该问题)
    local comm_on_attach = M.on_attach
    local server_dir = vim.fn.stdpath("config") .. "/lua/user/lsp/server"
    for _, file_name in ipairs(vim.fn.readdir(server_dir)) do
        require("user.lsp.server." .. string.gsub(file_name, "%.lua", "")).setup(comm_on_attach, M.format_buffer)
    end

    -- diagnostics to update while in insert mode
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        -- update_in_insert = true,
        severity_sort = false,
    })
end

function M.on_attach(client, bufnr)
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = ""
    }

    bufopts.desc = "Goto declaration"
    untils.set_keymap("n", "gD", vim.lsp.buf.declaration, bufopts, M.plugin_name)

    bufopts.desc = "Goto definition"
    untils.set_keymap("n", "gd", vim.lsp.buf.definition, bufopts, M.plugin_name)

    bufopts.desc = "Get hover"
    if client.server_capabilities.hoverProvider then
        untils.set_keymap("n", "K", vim.lsp.buf.hover, bufopts, M.plugin_name)
    end

    bufopts.desc = "Do implementation"
    if client.server_capabilities.implementationProvider then
        untils.set_keymap("n", "gi", vim.lsp.buf.implementation, bufopts, M.plugin_name)
    end

    bufopts.desc = "Get signature help"
    untils.set_keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts, M.plugin_name)
end

function M.format_buffer()
    local format_mark_ns = vim.api.nvim_create_namespace("")
    local bufnr = vim.api.nvim_win_get_buf(0)
    local windows = vim.fn.win_findbuf(bufnr)
    local marks = {}

    -- https://github.com/neovim/neovim/issues/14645
    -- use this code to ensure the cursor position is properly restored after formatting
    -- a buffer. The approach used supports restoring cursor for different windows using
    -- the same buffer
    for _, window in ipairs(windows) do
        local line, col = unpack(vim.api.nvim_win_get_cursor(window))
        marks[window] = vim.api.nvim_buf_set_extmark(bufnr, format_mark_ns, line - 1, col, {})
    end

    vim.lsp.buf.format({ bufnr = bufnr, async = false, })

    for _, window in ipairs(windows) do
        local mark = marks[window]
        local line, col = unpack(vim.api.nvim_buf_get_extmark_by_id(bufnr, format_mark_ns, mark, {}))
        local max_line_index = vim.api.nvim_buf_line_count(bufnr) - 1

        if line and col and line <= max_line_index then
            vim.api.nvim_win_set_cursor(window, { line + 1, col, })
        end
    end
end

return M
