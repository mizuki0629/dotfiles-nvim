local ensure_installed = {
    "stylua",
    "prettier",
    "stylelint",
}
if vim.fn.executable("python3") == 1 and vim.fn.executable("pip3") == 1 then
    table.insert(ensure_installed, "black") -- python formatter
    table.insert(ensure_installed, "isort") -- python import sort
    table.insert(ensure_installed, "ruff") -- python linter
end
if vim.fn.executable("go") == 1 then
    table.insert(ensure_installed, "gofumpt") -- go formatter
    table.insert(ensure_installed, "goimports") -- go import sort
    table.insert(ensure_installed, "golangci-lint") -- go linter
end

require("mason-null-ls").setup({
    ensure_installed = ensure_installed,
})
