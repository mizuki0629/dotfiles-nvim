require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'nord',
        disabled_filetypes = {},
        always_divide_middle = true,
        colored = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {'branch', 'diff',
            {
                'diagnostics',
                sources = { 'nvim_lsp' },
                sections = { 'error', 'warn', 'info', 'hint' },
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
                colored = true,           -- Displays diagnostics status in color if set to true.
            },
        },
        lualine_c = {
            {
                'filename',
                path = 1,
                file_status = true,
                shorting_target = 40,
                symbols = {
                    modified = ' [+]',
                    readonly = ' [RO]',
                    unnamed = '[Untitled]',
                    newfile = '[New]',
                }
            },
        },
        lualine_x = { },
        lualine_y = {'encoding', 'fileformat', 'filetype'

        },
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'nvim-tree', 'lazy', 'man', 'quickfix' }
}
