-- 取消所有模式下的方向建
vim.keymap.set({ "", "i" }, "<Up>", "<Nop>", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Down>", "<Nop>", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Left>", "<Nop>", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Right>", "<Nop>", { noremap = true, })

-- cmdline模式下的光标移动
vim.keymap.set("c", "<C-j>", "<Up>", { noremap = true, })
vim.keymap.set("c", "<C-k>", "<Down>", { noremap = true, })
vim.keymap.set("c", "<C-h>", "<Left>", { noremap = true, })
vim.keymap.set("c", "<C-l>", "<Right>", { noremap = true, })
