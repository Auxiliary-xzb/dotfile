local M = {}

M.plugin_name = "pylsp"

local function on_attach(client, bufnr_arg, format_buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.py" },
        callback = function ()
            format_buffer()
        end,
    })
end

function M.setup(comm_on_attach, format_buffer)
    require("lspconfig")[M.plugin_name].setup({
        on_attach = function (client, bufnr)
            comm_on_attach(client, bufnr)
            on_attach(client, bufnr, format_buffer)
        end,
    })
end

return M
