local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-cmp"

M.sources_names = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snippet]",
    nvim_lua = "[Lua]",
    nvim_lsp_signature_help = "[Signature]",
}

function M.setup(...)
    if untils.check_require("cmp") == false then
        return
    end

    if untils.check_require("luasnip") == false then
        return
    end

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
        window = {
            completion = {
                -- nvim_open_win使用的windows样式
                border = "rounded",

                -- 不显示scrollbar
                scrollbar = false,
            },
            documentation = {
                border = "rounded",
            },
        },
        completion = {
            keyword_length = 1,
        },
        formatting = {
            -- :help complete-items
            fields = { "abbr", "kind", "menu" },

            -- expand ~
            expandable_indicator = false,

            -- format
            format = function (entry, vim_item)
                vim_item.menu = M.sources_names[entry.source.name]
                return vim_item
            end,
        },
        matching = {
            disallow_fuzzy_matching = true,
            disallow_fullfuzzy_matching = true,
            disallow_partial_fuzzy_matching = true,
            disallow_partial_matching = true,
            disallow_prefix_unmatching = true,
        },
        snippet = {
            expand = function (args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = M.get_mapping(cmp, luasnip),
        sources = M.get_sources(cmp),
    })
end

function M.get_sources(cmp)
    return cmp.config.sources({
        {
            name = "nvim_lsp",
            entry_filter = function (entry, ctx)
                return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
            end,
        },
        { name = "luasnip" },
        -- { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
    })
end

function M.get_mapping(cmp, luasnip)
    return cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs( -4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip and luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
end

return M
