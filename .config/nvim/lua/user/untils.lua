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
    vim.keymap.set(mode, key, action, options)

    local value = { plugin = plugin, key = key, desc = options.desc, }
    table.insert(M.key_mappings, value)
end

return M
