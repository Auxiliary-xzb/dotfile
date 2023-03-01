local M = {}

M.failed_loaded = {
    -- unloaded plugin names
    -- name, name, ...
}

M.key_mappings = {
    -- the keymap with vim.key.set()
    -- plugin_name = { key_name, description }
}

function M.check_require(plugin_names)
    for _, item in ipairs(M.failed_loaded) do
        if item == plugin_names then
            return false
        end
    end

    if pcall(require, plugin_names) == false then
        table.insert(M.failed_loaded, plugin_names)
        return false
    end
    return true
end

function M.get_failed_loaded_list()
    print(vim.inspect(table.concat(M.failed_loaded, ", ")))
end

function M.whether_disable_netrw()
    local available_tree = { "nvim-tree" }

    for _, tree in ipairs(available_tree) do
        if pcall(require, tree) == true then
            return true
        end
    end
    return false
end

function M.set_keymap(mode, key, action, options, plugin)
    for _, value in ipairs(M.key_mappings) do
        if value.key == key then
            vim.notify("Key had registed by (" .. value.plugin .. ") plugin.")
            return
        end
    end

    vim.keymap.set(mode, key, action, options)

    local value = { plugin = plugin, key = key, desc = options.desc, }
    table.insert(M.key_mappings, value)
end

function M.get_keymap()
    -- print(vim.inspect(M.key_mappings))

    local ret = {}
    for _, x in ipairs(M.key_mappings) do
        local value = string.format("%-10s  %-5s  %s", x.plugin, x.key, x.desc)
        table.insert(ret, value)
    end
    return ret
end

function M.show_float()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, M.get_keymap())
    local win = vim.api.nvim_open_win(buf, true,
        {
            relative = "editor",
            width = 80,
            height = 20,
            col = 0,
            row = 2,
            anchor = "NW",
            style = "minimal",
            border = "rounded",
            title = "User define keymappings",
            title_pos = "center",
        })
end

return M
