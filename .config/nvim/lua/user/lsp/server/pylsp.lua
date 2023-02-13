local M = {}

M.plugin_name = "pylsp"

function M.setup(capabilities, comm_on_attach)
    require("lspconfig")[M.plugin_name].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            comm_on_attach(client, bufnr)
        end
    })
end

return M
