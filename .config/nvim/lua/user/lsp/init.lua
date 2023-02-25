-- just for debug
-- vim.lsp.set_log_level("trace")
-- require("vim.lsp.log").set_format_func(vim.inspect)
--
require("user.lsp.neodev").setup()
require("user.lsp.nvim-lspconfig").setup()
require("user.lsp.mason").setup()
