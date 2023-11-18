require("mason-null-ls").setup({
    ensure_installed = {
        "golangci-lint", -- go linter
        "gofumpt", -- go formatter
        "goimports", -- go import sort
        "black", -- python formatter
        "isort", -- python import sort
        "flake8", -- python linter
        "stylua", -- lua formatter
        -- "selene",
    }
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
