-- disable netrw if other plugin installed
local untils = require("user.untils")
if untils.whether_disable_netrw() == true then
  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

-- basic option setting
require("user.core.options")
require("user.core.keybindings")
require("user.core.autocmd")

-- plugin management
require('user.plugins')

-- setup colorscheme before other plugin
require("user.colorscheme")

-- lsp
require("user.lsp")

-- normal plugins
require("user.config")

-- snippets
require("user.snip")
