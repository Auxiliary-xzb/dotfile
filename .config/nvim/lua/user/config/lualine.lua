local untils = require("user.untils")

local M = {}

M.plugin_name = "lualine"

function M.setup(...)
    if untils.check_require("lualine") == false then
        return
    end

    require("lualine").setup{
        options = {
            -- theme
            theme = vim.g.colors_name,

            -- section间的分隔符
            section_separators = { left = "", right = "" },
            -- section中包含的component的分隔符
            component_separators = "",
        },
        sections = {
            lualine_c = {
                {
                    "filename",
                    fmt = function (filename, _)
                        local file_type = vim.api.nvim_get_option_value("filetype", { scope = "local" })
                        if file_type == "NvimTree" then
                            local home = vim.env.HOME
                            return string.gsub(vim.fn.getcwd(), home, "~")
                        end
                        return filename
                    end,
                },
            },
            lualine_x = {
                {
                    "filetype",
                    fmt = function (filetype, _)
                        return filetype:gsub("^%l", string.upper)
                    end,
                },
            },
            lualine_y = {
                {
                    "encoding",
                    fmt = function (encoding, _)
                        local coding = string.upper(encoding)
                        local tab_size = vim.api.nvim_get_option_value("softtabstop", { scope = "local" })
                        return string.format("%s  Tabs: %s", coding, tab_size)
                    end,
                },
                {
                    "fileformat",
                    symbols = {
                        unix = "Unix(LF)",
                        windows = "Windows(CRLF)",
                        mac = "Mac(CR)",
                    },
                },
            },
        },
    }
end

return M
