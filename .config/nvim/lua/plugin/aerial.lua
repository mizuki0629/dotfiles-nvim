require("aerial").setup({
    backends = {
        ['_']  = {"lsp", "treesitter"},
        python = {"lsp"},
        rust   = {"lsp"},
    },
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '<c-k>', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '<c-j>', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end,
})
