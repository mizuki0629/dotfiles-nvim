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

return require("lazy").setup({
    {
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        config = config("nordtheme"),
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
            "MasonUpdate",
        },
        config = config("mason"),
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = config("null-ls"),
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = config("lspconfig"),
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "folke/which-key.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "echasnovski/mini.icons",
        },
        event = "VeryLazy",
        config = config("which-key"),
    },

    -- LSP Progress UI
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "VeryLazy",
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        event = "InsertEnter",
        config = config("cmp"),
    },

    -- PowerLine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "arkav/lualine-lsp-progress",
        },
        config = config("lualine"),
    },
    -- Filer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config("nvim-tree"),
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = config("treesitter"),
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/which-key.nvim",
            "jvgrootveld/telescope-zoxide",
            "nvim-telescope/telescope-fzf-native.nvim",
            "AckslD/nvim-neoclip.lua",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-frecency.nvim",
        },
        tag = "0.1.4",
        init = function()
            require("which-key").add({
                { "<leader>f", group = "telescope" },
                { "<leader>f/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
                { "<leader>ff", "<cmd>Telescope frecency<cr>", desc = "frecency" },
                {
                    "<leader>fo",
                    "<cmd>Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git<CR>",
                    desc = "find files",
                },
                { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
            })
        end,
        cmd = "Telescope",
        config = config("telescope"),
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "folke/which-key.nvim",
        },
        version = "*",
        config = config("bufferline"),
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim",
            "gbprod/nord.nvim",
        },
        event = "VeryLazy",
        config = config("indent-blankline"),
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "petertriho/nvim-scrollbar",
        },
        event = "VeryLazy",
        config = config("gitsigns"),
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = config("comment"),
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        keys = { "<leader>a", "<cmd>AerialToggle!<cr>", mode = "n", desc = "Toggle Aerial" },
        config = config("aerial"),
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = config("nvim-scrollbar"),
    },
    {
        "mvllow/modes.nvim",
        tag = "v0.2.0",
        event = "VeryLazy",
        config = config("modes"),
    },
    {
        "kevinhwang91/nvim-hlslens",
        dependencies = {
            "petertriho/nvim-scrollbar",
        },
        event = "VeryLazy",
        config = config("nvim-hlslens"),
    },
    {
        "github/copilot.vim",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "rktjmp/lush.nvim",
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     event = "VeryLazy",
    --     config = config("notify"),
    -- },
    -- {
    --     "folke/noice.nvim",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    --     event = "VeryLazy",
    --     config = config("noice"),
    -- },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "VeryLazy",
        config = config("toggleterm"),
    },
    {
        "nastevens/vim-cargo-make",
    },
    {
        "mfussenegger/nvim-ansible",
        event = "VeryLazy",
    },
    {
        "norcalli/nvim-colorizer.lua",
        cmd = {
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerReloadAllBuffers",
            "ColorizerToggle",
        },
    },
})
