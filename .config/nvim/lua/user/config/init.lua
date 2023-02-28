local plugins = {
    ["init"] = false,
    ["nvim-web-devicons"] = true,
    ["indent-blankline"] = true,
    ["lualine"] = true,
    ["nvim-telescope"] = true,
    ["nvim-tree"] = true,
    ["nvim-treesitter"] = true,
    ["trouble"] = true,
    ["toggleterm"] = true,
    ["todo-comments"] = true,
}

local config_dir = vim.fn.stdpath("config") .. "/lua/user/config"
for _, file_name in ipairs(vim.fn.readdir(config_dir)) do
    if plugins[string.gsub(file_name, ".lua", "")] == true then
        require("user.config." .. string.gsub(file_name, ".lua", "")).setup()
    end
end
