local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local z_utils = require("telescope._extensions.zoxide.utils")
require('neoclip').setup()

local telescope = require("telescope")
telescope.setup({
    defaults = {
        layout_config = {
            width = 0.9,
            prompt_position = "top",
            preview_cutoff = 120,
            horizontal = { mirror = true },
            vertical = { mirror = true },
        },
        find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
        },
    },
    extentions = {
        repo = {
            list = {
                fd_opts = {
                    "--no-ignore-vcs",
                },
                search_dirs = {
                    "~/.local/share/nvim/lazy",
                },
            },
        },
        bookmarks = {
            selected_browser = "chrome"
        },
        zoxide = {
            {
                prompt_title = "[ Zoxide List ]",

                -- Zoxide list command with score
                list_command = "zoxide query -ls",
                mappings = {
                    default = {
                        action = function(selection)
                            vim.cmd.edit(selection.path)
                        end,
                        after_action = function(selection)
                            print("Directory changed to " .. selection.path)
                        end
                    },
                    ["<C-s>"] = { action = z_utils.create_basic_command("split") },
                    ["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
                    ["<C-e>"] = { action = z_utils.create_basic_command("edit") },
                    ["<C-b>"] = {
                        keepinsert = true,
                        action = function(selection)
                            builtin.file_browser({ cwd = selection.path })
                        end
                    },
                    ["<C-f>"] = {
                        keepinsert = true,
                        action = function(selection)
                            builtin.find_files({ cwd = selection.path })
                        end
                    },
                    ["<C-t>"] = {
                        action = function(selection)
                            vim.cmd.tcd(selection.path)
                        end
                    },
                }
            }
        },
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
        },
    },
})

telescope.load_extension('repo')
telescope.load_extension('bookmarks')
telescope.load_extension('zoxide')
telescope.load_extension('neoclip')
telescope.load_extension('file_browser')

require("which-key").register({
    f = {
        name = "telescope",
        f = { builtin.find_files, "Find Files" },
        g = { builtin.live_grep, "Live Grep" },
        b = { builtin.buffers, "Buffers" },
        c = { builtin.git_commits, "git commits" },
        z = { telescope.extensions.zoxide.list, "Zoxide List" },
    },
}, { prefix = "<leader>" })
