local untils = require("user.untils")

local M = {}

M.plugin_name = "mason"

function M.setup(...)
    if untils.check_require("mason") == false then
        return
    end

    require("mason").setup({
        -- the directory in which to install packages
        install_root_dir = vim.fn.stdpath("data") .. "site/mason",
        ui = {
            -- whether to automatically check for new versio when
            -- opening the :Mason window.
            check_outdated_packages_on_open = false,
        },
    })
end

return M
