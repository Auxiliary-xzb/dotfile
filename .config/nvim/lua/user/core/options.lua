-- 使用空白替换空白符，只影响由vim执行的tab操作。
vim.opt.expandtab = true
-- 开启时行首的tab使用shiftwidth，行首删除时也会使用shiftwidth，其他地方使用tabstop。
-- 关闭时总是使用tabstop，shiftwidth只有在是使用">>"进行格式化时才使用
-- tab最终会被插入为tab还是space取决与expandtab
vim.opt.smarttab = true
-- 实际执行插入tab操作时，tab所代表的多少个space的位宽，
vim.opt.softtabstop = 4
-- 首部空白(indent)的宽度，它应该和插入tab的space位宽相同，不然会很奇怪
vim.opt.shiftwidth = 4
-- 表示显示tab时使用的space位宽，为了保证读取文件的正确，应该将tab的显示
-- 位宽保持默认的8个符号位。
-- vim.opt.tabstop = 8

-- 设置显示行号, 显示相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 显示所有的空白符，长行时不换行，当光标到长行尾部时，尾部
-- 自动显示后续10个字符，设置nowrap时显示的行首和行尾字符
vim.opt.list = true
vim.opt.wrap = false
vim.opt.sidescroll = 10
vim.opt.listchars = { precedes = "<", extends = ">" }

-- 光标可以移动至空白处
vim.opt.virtualedit = { "onemore", "insert" }

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
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 999

-- 显示当前正在编辑的行
vim.opt.cursorline = true

-- 默认在当前窗口右边进行分屏
vim.opt.splitright = true

-- 光标上下两侧最少保留的屏幕行数
vim.opt.scrolloff = 8

-- 以下说明来源于mbyte.txt
-- 1. nvim内部使用UTF-8编码，encoding选项会被设置utf—8且不可修改。
-- 2. nvim可以编辑不同编码的文件，但是在读取该文件或写回该文件时，nvim
--    将自动进行转码，fileencoding和encoding比对，不相同则转码。
-- 3. fileencodings用于标识vim可识别的文件编码，当已经存在的文件被编辑
--    时，vim会根据fileencodings列表来检测文件编码，检测通过后将fileencoding
--    设置为已经识别到的编码，否则将该文件设置为UTF-8编码
-- 4. 对于由vim创建的新文件而言，vim不再使用fileencodings检测，而是直接
--    使用fileencoding来标识文件编码。
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,gbk,gb2312"
vim.opt.fileformat = "unix"

-- to always use the clipboard for all operations
vim.opt.clipboard:append("unnamedplus")

-- 关闭部分插件功能。
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0

-- 总是显示符号列，且位宽为1
vim.opt.signcolumn = "yes:1"

-- 所有的popmenu的最大高度为10行
vim.opt.pumheight = 10

-- 设置单一的stausline，而不是每个窗口一个
vim.opt.laststatus = 3
