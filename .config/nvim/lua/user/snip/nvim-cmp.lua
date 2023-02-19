local untils = require("user.untils")

local M = {}

M.plugin_name = "nvim-cmp"

function M.setup(...)
    if untils.check_require("cmp") == false then
        return
    end

    local luasnip = nil
    local cmp = require("cmp")
    if untils.check_require("luasnip") then
        luasnip = require("luasnip")
    end

    cmp.setup({
      snippet = M.get_snippet(cmp),
      mapping = M.get_mapping(cmp, luasnip),
      sources = M.get_sources(cmp)
    })
end

function M.get_snippet(cmp)
    return {
        expand = function(args)
            if M.luasnip then
              M.luasnip.lsp_expand(args.body)
            end
        end,
      }
end

function M.get_sources(cmp)
    return cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    })
end

function M.get_mapping(cmp, luasnip)
    return cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
end

return M