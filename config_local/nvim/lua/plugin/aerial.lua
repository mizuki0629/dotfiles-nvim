return {
    'stevearc/aerial.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    init = function ()
        vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
    end,
    opts = {
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
    }
}
