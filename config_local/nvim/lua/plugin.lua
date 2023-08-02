local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local config = function(name)
    return function()
        require("plugin." .. name)
    end
end

local use = function(name)
    return require("plugin." .. name)
end

return require('lazy').setup({
    use 'nordtheme',
    use 'which-key',
    use 'mason',
    use 'lspconfig',

    -- LSP Progress UI
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = true,
    },
    use 'cmp',

    -- PowerLine
    {
        'nvim-lualine/lualine.nvim',
        config = config("lualine"),
        dependencies = {
            'arkav/lualine-lsp-progress'
        },
    },
    'nastevens/vim-cargo-make',
    -- Filer
    {
        'nvim-tree/nvim-tree.lua',
        config = config("nvim-tree"),
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        'nvim-treesitter/nvim-treesitter',
        config = config("treesitter"),
    },
    {
        'nvim-treesitter/playground',
        build = ":TSInstall query",
        config = config("playground"),
    },
    use 'nu',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "folke/which-key.nvim",
            'cljoly/telescope-repo.nvim',
            'jvgrootveld/telescope-zoxide',
            'dhruvmanila/browser-bookmarks.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'AckslD/nvim-neoclip.lua',
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = config("telescope"),
    },
    use 'null-ls',
    use 'mason-null-ls',
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "folke/which-key.nvim",
        },
        config = config("bufferline"),
    },
    'p00f/nvim-ts-rainbow',
    {
        "lukas-reineke/indent-blankline.nvim",
        config = config("indent-blankline"),
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { "petertriho/nvim-scrollbar" },
        config = config("gitsigns"),
    },
    {
        'numToStr/Comment.nvim',
        config = config("comment"),
    },
    use 'aerial',
    {
        "petertriho/nvim-scrollbar",
        config = config("nvim-scrollbar"),
    },
    {
        'mvllow/modes.nvim',
        tag = 'v0.2.0',
        config = config("modes"),
    },
    {
        'kevinhwang91/nvim-hlslens',
        dependencies = { "petertriho/nvim-scrollbar" },
        config = config("nvim-hlslens"),
    },
    {
        'github/copilot.vim',
    },

})
