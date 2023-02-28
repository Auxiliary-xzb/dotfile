local untils = require("user.untils")

M = {}

M.plugin_name = "todo-comments"

function M.setup(...)
    if untils.check_require(M.plugin_name) == false then
        return
    end

    require("todo-comments").setup()
end

return M
