local M = {}

M.ls = require("luasnip")
M.s = M.ls.snippet
M.sn = M.ls.snippet_node
M.isn = M.ls.indent_snippet_node
M.t = M.ls.text_node
M.i = M.ls.insert_node
M.f = M.ls.function_node
M.c = M.ls.choice_node
M.d = M.ls.dynamic_node
M.r = M.ls.restore_node
M.events = require("luasnip.util.events")
M.ai = require("luasnip.nodes.absolute_indexer")
M.extras = require("luasnip.extras")
M.fmt = M.extras.fmt
M.m = M.extras.m
M.l = M.extras.l
M.postfix = require("luasnip.extras.postfix").postfix

return M
