local M = {}

M.plugin_name = "clangd"


-- TODO: move to comm
local function format_buffer()
  local format_mark_ns = vim.api.nvim_create_namespace("")
  local bufnr = vim.api.nvim_win_get_buf(0)
  local windows = vim.fn.win_findbuf(bufnr)
  local marks = {}

  -- https://github.com/neovim/issues/14645
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

local function on_attach(client, bufnr_arg)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.c", "*.cpp", "*.cc", "*.h" },
        callback = function()
            -- vim.lsp.buf.format({bufnr = bufnr_arg, async = false})
            format_buffer()
        end
    })

    local options = { noremap = true, silent = true }
    untils.set_keymap("n", "<F4>", function() vim.cmd("ClangdSwitchSourceHeader") end, options,
        M.plugin_name, "Clangd switch source and header")
end

function M.setup(capabilities, comm_on_attach)
    if not vim.fn.executable('clangd') then
        vim.notify("Can't found clangd.")
        return
    end

    require("lspconfig")[M.plugin_name].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            comm_on_attach(client, bufnr)
            on_attach(client, bufnr)
        end
    })
end

return M
