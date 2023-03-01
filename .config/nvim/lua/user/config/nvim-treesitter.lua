local untils = require("user.untils")

local M = {}

M.disable_highlight = { "cmake" }

function M.setup(...)
    if untils.check_require("nvim-treesitter") == false then
        return
    end

    require("nvim-treesitter.configs").setup({
        -- A list parser names
        ensure_installed = { "bash", "c", "cmake", "cpp", "diff", "dot",
            "git_rebase", "gitattributes", "gitcommit", "gitignore",
            "help", "make", "lua", "python", "vim" },
        -- install parsers synchronously (only applied to 'ensure_installed')
        sync_install = false,
        -- Automatically install missing parsers entering buffer
        auto_install = true,
        highlight = {
            -- 'false' will disable the whole extension
            enable = true,

            -- use function for more flexibility
            -- disable slow treesitter highlight for large file
            disable = function (lang, buf)
                for _, module_name in ipairs(M.disable_highlight) do
                    if lang == module_name then
                        return true
                    end
                end

                local max_filesize = 1024 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    })

    vim.api.nvim_create_autocmd(
        { "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
        group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
        callback = function ()
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr   = "nvim_treesitter#foldexpr()"
        end,
    })
end

return M
