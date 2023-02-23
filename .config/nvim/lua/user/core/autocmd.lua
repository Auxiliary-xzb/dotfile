-- commActionGroup --
local commActionGroup = vim.api.nvim_create_augroup('CommAction', { clear = true })
vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*',
  group = commActionGroup,
  callback = function()
    local currentPosition = vim.api.nvim_win_get_cursor(0)
    -- 删除行尾空白符
    vim.cmd('silent %s/\\s*$//g')
    -- 替换Tab为空格
    vim.cmd('silent %retab!')
    vim.api.nvim_win_set_cursor(0, currentPosition)
  end
})

-- fileTypeGroup --
local fileTypeGroup = vim.api.nvim_create_augroup('FileTypeDetect', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hpp"},
  group = fileTypeGroup,
  callback = function()
    -- 输入闭合括号时短暂跳转到匹配处
    vim.opt_local.showmatch = true
    -- 保持之间0.5ms
    vim.opt_local.matchtime = 5
    vim.opt_local.foldmethod = 'syntax'
    vim.opt_local.foldcolumn = 1
    vim.opt_local.foldlevel = 999
  end
})

