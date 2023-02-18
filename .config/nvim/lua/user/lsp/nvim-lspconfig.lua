local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-lspconfig"

function M.setup(...)
    if untils.check_require("lspconfig") == false then
        return
    end

    local comm_on_attach = M.on_attach
    local server_dir = vim.fn.stdpath("config") .. "/lua/user/lsp/server"
    for _, file_name in ipairs(vim.fn.readdir(server_dir)) do
        require("user.lsp.server." .. string.gsub(file_name, "%.lua", ""))
                .setup(M.capabilities, comm_on_attach, M.format_buffer)
    end
end

function M.on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    untils.set_keymap("n", "gD", vim.lsp.buf.declaration, bufopts,
        M.plugin_name, "Goto declaration")
    untils.set_keymap("n", "gd", vim.lsp.buf.definition, bufopts,
        M.plugin_name, "Goto definition")

    if client.server_capabilities.hoverProvider then
        untils.set_keymap("n", "K", vim.lsp.buf.hover, bufopts,
            M.plugin_name, "Get hover")
    end

    if client.server_capabilities.implementationProvider then
        untils.set_keymap("n", "gi", vim.lsp.buf.implementation, bufopts,
            M.plugin_name, "Do implementation")
    end

    untils.set_keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts,
            M.plugin_name, "Get signature help")
end

function M.get_capabilities()
    if untils.check_require("cmp_nvim_lsp") then
        return require("cmp_nvim_lsp").default_capabilities()
    end
    return nil
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

  vim.lsp.buf.format({ bufnr = bufnr, async = false})

  for _, window in ipairs(windows) do
    local mark = marks[window]
    local line, col = unpack(vim.api.nvim_buf_get_extmark_by_id(bufnr, format_mark_ns, mark, {}))
    local max_line_index = vim.api.nvim_buf_line_count(bufnr) - 1

    if line and col and line <= max_line_index then
      vim.api.nvim_win_set_cursor(window, { line + 1, col })
    end
  end
end

M.capabilities = M.get_capabilities()

return M
