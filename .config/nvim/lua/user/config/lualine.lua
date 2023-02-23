local untils = require("user.untils")

local M = {}

M.plugin_name = "lualine"

function M.setup(...)
  if untils.check_require("lualine") == false then
    return
  end

  require("lualine").setup {
    options = {
      -- theme
      theme = vim.g.colors_name,

      component_separators = "|",
      section_separators = "",
    },
  }
end

return M
