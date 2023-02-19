local alias = require("user.snip.snippets")

local M = {}

M.filetype = "cpp"

local function main()
    return alias.s("main", {
        alias.t({"int main(int args, char *argv[]) {", "  "}),
        alias.i(1),
        alias.t({"", "  return 0;", "}"})
    })
end

function M.setup(...)
    alias.ls.add_snippets(M.filetype, { main() })
end

return M
