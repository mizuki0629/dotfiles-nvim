vim.lsp.config('*', {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = nil

        require("which-key").add({
            { "gd", vim.lsp.buf.definition, desc = "Definition", buffer = bufnr },
            { "K", vim.lsp.buf.hover, desc = "Hover", buffer = bufnr },
            { "gl", vim.diagnostic.open_float, desc = "Line diagnostics", buffer = bufnr },
            {
                "[d",
                function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end,
                desc = "Prev diagnostic",
                buffer = bufnr,
            },
            {
                "]d",
                function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end,
                desc = "Next diagnostic",
                buffer = bufnr,
            },
        })
    end,
})
