local untils = require("user.untils")

local M = {}

M.plugin_name = "pylsp"

function M.setup(capabilities, comm_on_attach)
    print("xxxxxxxxx")
    require("lspconfig").clangd.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            comm_on_attach(client, bufnr)
        end
    })
end

return M
