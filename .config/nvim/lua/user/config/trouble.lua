local untils = require("user.untils")

local M = {}

M.plugin_name = "trouble"

function M.setup(...)
  if untils.check_require("trouble") == false then
    return
  end

  require("trouble").setup({
    --  use devicons for filenames
    icons = untils.check_require("nvim-web-devicons"),

    -- add an extra new line on top of the list
    padding = false,

    -- automatically open the list when you have diagnostics
    -- auto_open = true,

    -- automatically clase the list when you have no diagostics
    -- auto_close = true,
  })

  local options = { noremap = true, silent = true }
  untils.set_keymap("n", "<F3>", function() vim.cmd("TroubleToggle") end, options,
  M.plugin_name, "Toggle trouble")
end

return M


