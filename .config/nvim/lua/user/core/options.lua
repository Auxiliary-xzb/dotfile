-- 仅使用空格模式, 不替换<Tab>的实际长度，替换其他涉及<Tab>的动作使用的长度
-- 仅控制新创建文件，保持旧文件的tab长度，仅将其替换为空白。
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- 设置显示行号, 显示相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 显示所有的空白符，长行时不换行，当光标到长行尾部时，尾部
-- 自动显示后续10个字符，设置nowrap时显示的行首和行尾字符
vim.opt.list = true
vim.opt.wrap = false
vim.opt.sidescroll = 10
vim.opt.listchars= { precedes = '<', extends = '>' }

-- 光标可以移动至空白处
vim.opt.virtualedit = {'onemore', 'insert'}

-- 设置不启用备份文件，临时文件，撤销文件
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false

-- 设置高亮显示，增量搜索显示，忽略大小写，折返查找
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.wrapscan = true

-- 使用增强的命令行补全
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.cmdheight = 2

-- 设置切换buffer时不提示有修改，而是把它当做隐藏buffer
vim.opt.hidden = true

-- 设置折叠的默认方式
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 999

-- 显示当前正在编辑的行
vim.opt.cursorline = true

-- 默认在当前窗口右边进行分屏
vim.opt.splitright = true

-- 光标上下两侧最少保留的屏幕行数
vim.opt.scrolloff = 8

vim.opt.clipboard:append("unnamedplus")

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
