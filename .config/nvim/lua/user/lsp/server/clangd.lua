local untils = require("user.untils")

local M = {}

M.plugin_name = "clangd"

local function on_attach(client, bufnr_arg)
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.c", "*.cpp", "*.cc", "*.h" },
        callback = function()
            vim.lsp.buf.format({bufnr = bufnr_arg, async = true})
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

    require("lspconfig").clangd.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            comm_on_attach(client, bufnr)
            on_attach(client, bufnr)
        end
    })
end

return M
