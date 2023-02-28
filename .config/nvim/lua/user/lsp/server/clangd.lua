local untils = require("user.untils")

local M = {}

M.plugin_name = "clangd"

local function on_attach(client, bufnr_arg, format_buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.c", "*.cpp", "*.cc", "*.h" },
        callback = function ()
            -- vim.lsp.buf.format({bufnr = bufnr_arg, async = false})
            format_buffer()
        end,
    })

    local options = {
        noremap = true,
        silent = true,
        buffer = bufnr_arg,
        desc = "Clangd switch source and header"
    }
    untils.set_keymap("n", "<F4>", function () vim.cmd("ClangdSwitchSourceHeader") end, options, M.plugin_name)
end

function M.setup(comm_on_attach, format_buffer)
    if not vim.fn.executable("clangd") then
        vim.notify("Can't found clangd.")
        return
    end

    require("lspconfig")[M.plugin_name].setup({
        cmd = { "clangd",
            "--function-arg-placeholders=true",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--completion-style=detailed",
            "--clang-tidy",
            "--clang-tidy-checks=cppcoreguidelines-*,performance-*,bugprone-*,portability-*, modernze-*,google-*" },
        on_attach = function (client, bufnr)
            comm_on_attach(client, bufnr)
            on_attach(client, bufnr, format_buffer)
        end,
    })
end

return M
