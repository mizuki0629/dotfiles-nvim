local ensure_installed = {
        "stylua", -- lua formatter
}
local null_ls = require("null-ls")
local source = {
    null_ls.builtins.formatting.stylua, -- lua formatter
}
if vim.fn.executable("python3") == 1 and vim.fn.executable("pip3") == 1 then
    table.insert(ensure_installed, "black") -- python formatter
    table.insert(ensure_installed, "isort") -- python import sort
    table.insert(ensure_installed, "ruff") -- python linter
    table.insert(source, null_ls.builtins.formatting.black) -- python formatter
    table.insert(source, null_ls.builtins.formatting.isort) -- python import sort
    table.insert(source, null_ls.builtins.diagnostics.ruff) -- python linter
end
if vim.fn.executable("go") == 1 then
    table.insert(ensure_installed, "gofumpt") -- go formatter
    table.insert(ensure_installed, "goimports") -- go import sort
    table.insert(ensure_installed, "golangci-lint") -- go linter
    table.insert(source, null_ls.builtins.formatting.gofumpt) -- go formatter
    table.insert(source, null_ls.builtins.formatting.goimports) -- go import sort
    table.insert(source, null_ls.builtins.diagnostics.golangci_lint) -- go linter
end
require("mason-null-ls").setup({
    ensure_installed = ensure_installed
})

null_ls.setup({
    sources = source
})
