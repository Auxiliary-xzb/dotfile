local M = {}

M.plugin_name = "lua_ls"

local function on_attach(client, bufnr_arg, format_buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua" },
        callback = function ()
            format_buffer()
        end,
    })
end

function M.setup(comm_on_attach, format_buffer)
    if vim.fn.executable("lua-language-server") == false then
        vim.notify("Can't found lua-language-server")
        return
    end

    require("lspconfig")[M.plugin_name].setup({
        on_attach = function (client, bufnr)
            comm_on_attach(client, bufnr)
            on_attach(client, bufnr, format_buffer)
        end,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                },
                diagnostics = {
                    neededFileStatus = {
                        ["codestyle-check"] = "Any"
                    },
                },
                format = {
                    enable = true,
                },
            },
        },
    })
end

return M
