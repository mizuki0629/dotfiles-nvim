local ensure_installed = {
    "stylua",
}

if vim.fn.executable("npm") == 1 then
    table.insert(ensure_installed, "stylelint") -- css linter
    table.insert(ensure_installed, "prettier")  -- js formatter
end

if vim.fn.executable("python3") == 1 and vim.fn.executable("pip3") == 1 then
    table.insert(ensure_installed, "black") -- python formatter
    table.insert(ensure_installed, "isort") -- python import sort
end

require("mason-null-ls").setup({
    ensure_installed = ensure_installed,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
    },
})
