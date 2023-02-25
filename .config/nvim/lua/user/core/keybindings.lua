-- 取消所有模式下的方向建
vim.keymap.set({ "", "i" }, "<Up>", "", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Down>", "", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Left>", "", { noremap = true, })
vim.keymap.set({ "", "i" }, "<Right>", "", { noremap = true, })

-- open help in another tab page for full screen
vim.cmd(":cnoreabbrev help tab help")

function open_help_on_new_tab()
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
        for _, buffer in ipairs(vim.fn.tabpagebuflist(tabpage)) do
            if vim.filetype.match({ buf = buffer, }) == "help" then
                vim.cmd("tabclose " .. tabpage)
            end
        end
    end
end

vim.cmd(
    "command! ClearReg for i in range(34, 122) | slient! call setreg(nr2char(i), []) | endfor")
