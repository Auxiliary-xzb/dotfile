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
        require("user.lsp.server." .. string.gsub(file_name, "%.lua", "")).setup(M.capabilities, comm_on_attach)
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

M.capabilities = M.get_capabilities()

return M
