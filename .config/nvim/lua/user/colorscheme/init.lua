local hour = tonumber(os.date("%H"))

-- 根据系统的当前时间切换主题。
if hour >= 22 or (hour >= 0 and hour <= 8) then
    require("user.colorscheme.tokyonight").setup()
else
    require("user.colorscheme.github-nvim-theme").setup()
end
