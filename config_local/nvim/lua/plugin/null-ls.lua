local ensure_installed = {
        "stylua", -- lua formatter
}
if vim.fn.executable("python3") then
    table.insert(ensure_installed, "black") -- python formatter
    table.insert(ensure_installed, "isort") -- python import sort
    table.insert(ensure_installed, "flake8") -- python linter
end
if vim.fn.executable("go") then
    table.insert(ensure_installed, "gofumpt") -- go formatter
    table.insert(ensure_installed, "goimports") -- go import sort
    table.insert(ensure_installed, "golangci-lint") -- go linter
end
require("mason-null-ls").setup({
    ensure_installed = ensure_installed
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.gofumpt, -- go formatter
        null_ls.builtins.formatting.goimports, -- go import sort
        null_ls.builtins.diagnostics.golangci_lint, -- go linter
        null_ls.builtins.formatting.black, -- python formatter
        null_ls.builtins.formatting.isort, -- python import sort
        null_ls.builtins.diagnostics.flake8, -- python linter
        null_ls.builtins.formatting.stylua, -- lua formatter
        --null_ls.builtins.diagnostics.selene, -- lua linter
    },
})
