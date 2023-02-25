local M = {}

M.plugin_name = "lua_ls"

local function on_attach(client, bufnr_arg, format_buffer)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua" },
    callback = function()
      format_buffer()
    end
  })

end

function M.setup(comm_on_attach, format_buffer)
    if vim.fn.executable("lua-language-server") == false then
        vim.notify("Can't found lua-language-server")
        return
    end

    require("lspconfig")[M.plugin_name].setup({
      on_attach = function(client, bufnr)
          comm_on_attach(client, bufnr)
          on_attach(client, bufnr, format_buffer)
      end,
      settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        },
        diagnostics = {
            neededFileStatus = {
                ["codestyle-check"] = "Any"
            }
        },
        format = {
          enable = true,
          defaultConfig = {
            -- 所有字符串使用引号，但是包含未转义字符时不会格式化
            quote_style = "double",
            -- 最大行宽为50
            max_line_length = "80",
            -- 一律添加表的末尾项的分割符号
            trailing_table_separator = "always",
            -- 调用函数参数被换行时对齐到第一个参数的位置
            align_call_args = "true",
            -- 函数定义的参数列表被换行时对齐到第一个参数的位置
            align_function_params = "true",
            -- 在连续的赋值语句中，只要有一行的等号与左侧符号距离大于1
            -- 个空格，就采取最小对齐原则对齐等号。
            align_continuous_assign_statement = "true",
          }
        },
      }
    }

    })
end

return M
