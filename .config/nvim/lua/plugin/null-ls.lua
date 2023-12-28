local null_ls = require("null-ls")
local source = {
    null_ls.builtins.formatting.stylua,    -- lua formatter
    null_ls.builtins.formatting.stylelint, -- css linter
    null_ls.builtins.formatting.prettier,  -- javascript formatter
}
if vim.fn.executable("python3") == 1 and vim.fn.executable("pip3") == 1 then
    table.insert(source, null_ls.builtins.formatting.black) -- python formatter
    table.insert(source, null_ls.builtins.formatting.isort) -- python import sort
    table.insert(source, null_ls.builtins.diagnostics.ruff) -- python linter
end
if vim.fn.executable("go") == 1 then
    table.insert(source, null_ls.builtins.formatting.gofumpt)        -- go formatter
    table.insert(source, null_ls.builtins.formatting.goimports)      -- go import sort
    table.insert(source, null_ls.builtins.diagnostics.golangci_lint) -- go linter
end
null_ls.setup({
    sources = source,
})
