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
M.key_mappings = {
  -- cd in the direcotry under the cursor, this will change root
  -- the <CR> only open the directory without changing root
  { mode = "n", key = "o",
  action = { "tree", "change_root_to_node" },
  description = "Cd directory and change the root direcotry" },

  -- open file
  { mode = "n", key = "v",
  action = { "node", "open", "vertical" },
  description = "Open file" },

  -- move cursor to parent directory
  { mode = "n", key = "gp",
  action = { "node", "navigate", "parent" },
  description = "Move cursor to parent direcotry" },

  -- copy absolute path to system clipbroad
  { mode = "n", key = "yy",
  action = { "fs", "copy", "absolute_path" },
  description = "Copy absolute path to system clipbroad" },

  -- open file or directory with system default application
  { mode = "n", key = "S",
  action = { "node", "run", "system" },
  description = "Open file or directory with system default application" },

  -- collapse the whole tree
  { mode = "n", key = "<C-c>",
  action = { "tree", "collapse_all" },
  description = "Collapse the whole tree" },

  -- expand all
  { mode = "n", key = "<C-o>",
  action = { "tree", "expand_all" },
  description = "Expand the whole tree" },

  -- search node
  { mode = "n", key = "s",
  action = { "tree", "search_node" },
  description = "Search file node" },

  -- toggle a popup with file infos
  { mode = "n", key = "K",
  action = { "node", "show_info_popup" },
  description = "Toggle a popup with file infos" },

  -- toggle key mapping help
  { mode = "n", key = "h",
  action = { "tree", "toggle_help" },
  description = "Toggle key mapping help" },

  -- disable bookmark now, enable later
}

M.disabled_keys = {
  "<C-]>", "<C-e>", "O", "<C-v>", "<C-x>", "<C-t>", "<", ">",
  "P", "<BS>", "K", "J", "C", "I", "H", "B", "U", "D",
  "<C-r>", "e", "Y", "[e", "[c", "]e", "]c", "-", "f", "F",
  "W", "E", "<C-k>", "g?", "m", "bmv"
}

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
    modified = { enable = true },

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

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = M.open_directory_in_current_window
  })

  untils.set_keymap({ "n", "i" }, "<F2>", function()
    -- if the no name buffer toggle nvim-tree
    if vim.api.nvim_buf_get_name(0) == "" then
      vim.cmd("NvimTreeToggle")
    else
      vim.cmd("NvimTreeFindFileToggle")
    end
  end, { noremap = true, silent = true },
  M.plugin_name, "Toggle nvim-tree")
end

function M.on_attach(bufnr)
  local options = { noremap = true, silent = true, buffer = bufnr }
  for _, key_name in ipairs(M.disabled_keys) do
    untils.set_keymap("n", key_name, "", options,
    M.plugin_name, "Disable nvim-tree default keymap")
  end

  for _, value in ipairs(M.key_mappings) do
    local action = require("nvim-tree.api")
    -- get function
    for _, sub_action in ipairs(value.action) do
      action = action[sub_action]
    end
    untils.set_keymap(value.mode, value.key, function() action() end, options,
    M.plugin_name, value.description)
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
