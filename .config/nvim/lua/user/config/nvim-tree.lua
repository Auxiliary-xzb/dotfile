local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-tree"

-- keep minimum
--  key     discriptoin
-- <Enter>  open file / direcotry
-- <Tab>    open the file as a preview (keeps the cursor in the rree)
-- R        refresh the tree
-- a        create a file, direcotry for trailing '/'
-- d        delete a file
-- r        rename
-- x        cut file/directory to clipbroad
-- c        copy file/direcotry to clipbroad
-- p        paste from clipboard;
-- y        copy name
-- Y        relative path
-- q        close tree window
-- .        enter vim command mode with the file under the cursor
local function get_keymappings()
    local nvim_tree = require("nvim-tree.api")
    return {
        -- default mapping.
        -- cd in the direcotry under the cursor, this will change root
        -- the <CR> only open the directory without changing root
        { mode = "n", key = "<CR>",  action = nvim_tree.node.open.edit,           desc = "Open file / direcotry" },
        { mode = "n", key = "<Tab>", action = nvim_tree.node.open.preview,        desc = "Open file as a preview (keeps the cursor int the tree)" },
        { mode = "n", key = "a",     action = nvim_tree.fs.create,                desc = "Create a file, direcotry for trailing '/' " },
        { mode = "n", key = "d",     action = nvim_tree.fs.remove,                desc = "Delete a file" },
        { mode = "n", key = "r",     action = nvim_tree.fs.rename,                desc = "Rename" },
        { mode = "n", key = "x",     action = nvim_tree.fs.cut,                   desc = "Cut file/direcotry to clipboard" },
        { mode = "n", key = "c",     action = nvim_tree.fs.copy.node,             desc = "Copy file/direcotry to clipbroad" },
        { mode = "n", key = "p",     action = nvim_tree.fs.paste,                 desc = "Paste from clipbroad" },
        { mode = "n", key = "y",     action = nvim_tree.fs.copy.filename,         desc = "Copy name" },
        { mode = "n", key = "Y",     action = nvim_tree.fs.copy.relative_path,    desc = "Copy relative path" },
        { mode = "n", key = "q",     action = nvim_tree.tree.close,               desc = "Close nvim-tree window" },
        { mode = "n", key = ".",     action = nvim_tree.node.run.cmd,             desc = "Enter vim command mode with the file under the cursor" },
        { mode = "n", key = "o",     action = nvim_tree.tree.change_root_to_node, desc = "Cd directory and change the root direcotry" },

        -- user mapping
        { mode = "n", key = "v",     action = nvim_tree.node.open.vertical,       desc = "Open file" },
        { mode = "n", key = "gp",    action = nvim_tree.node.navigate.parent,     desc = "Move cursor to parent direcotry" },
        { mode = "n", key = "yy",    action = nvim_tree.fs.copy.absolute_path,    desc = "Copy absolute path to system clipbroad" },
        { mode = "n", key = "S",     action = nvim_tree.node.run.system,          desc = "Open file or directory with system default application" },
        { mode = "n", key = "<C-c>", action = nvim_tree.tree.collapse_all,        desc = "Collapse the whole tree" },
        { mode = "n", key = "<C-o>", action = nvim_tree.tree.expand_all,          desc = "Expand the whole tree" },
        { mode = "n", key = "s",     action = nvim_tree.tree.search_node,         desc = "Search file node" },
        { mode = "n", key = "K",     action = nvim_tree.node.show_info_popup,     desc = "Toggle a popup with file infos" },
        { mode = "n", key = "h",     action = nvim_tree.tree.toggle_help,         desc = "Toggle key mapping help" },
    }
end

function M.setup(...)
    if untils.check_require("nvim-tree") == false then
        return
    end

    require("nvim-tree").setup({
        on_attach = M.on_attach,
        disable_netrw = true,
        -- replace unnamed buffer
        hijack_unnamed_buffer_when_opening = true,
        -- keeps cursor on the first letter of filename
        hijack_cursor = true,
        -- automatically reloads tree on bufenter nvim-tree
        reload_on_bufenter = true,
        -- indicate which file have unsaved modification
        modified = { enable = true, },
        -- git
        git = {
            -- Enable / disable the feature
            enable = true,

            -- ignore files based on .gitignore
            ignore = false,
        },
        -- ui
        renderer = {
            -- appends a trailing slash to folder names
            add_trailing = true,

            -- compact folders that only contains a single folder
            -- group_empty = true,

            -- highlight for git attribute
            highlight_git = true,

            -- do not show then destination of the symlink
            symlink_destination = false,
        },
    })

    vim.api.nvim_create_autocmd("VimEnter", { callback = M.open_directory_in_current_window, })

    untils.set_keymap({ "n", "i" }, "<F2>", function ()
        -- if the no name buffer toggle nvim-tree
        if vim.api.nvim_buf_get_name(0) == "" then
            vim.cmd("NvimTreeToggle")
        else
            vim.cmd("NvimTreeFindFileToggle")
        end
    end, { noremap = true, silent = true, desc = "Toggle nvim-tree" }, M.plugin_name)
end

function M.on_attach(bufnr)
    local options = { noremap = true, silent = true, buffer = bufnr, desc = "" }

    local keymappings = get_keymappings()
    for _, value in ipairs(keymappings) do
        options.desc = value.desc
        untils.set_keymap(value.mode, value.key, value.action, options, M.plugin_name)
    end
end

function M.open_directory_in_current_window(data)
    -- buffer is a direcotry
    if vim.fn.isdirectory(data.file) == 0 then
        return
    end

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

return M
