local current_hour = tonumber(os.date("%H"))

-- 根据系统的当前时间切换主题。
if current_hour >= 22 then
    require("user.colorscheme.tokyonight").setup()
else
    require("user.colorscheme.github-nvim-theme").setup()
end
