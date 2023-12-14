vim.opt.termguicolors = true
local bufferline = require('bufferline')
bufferline.setup{
    options = {
        right_mouse_command = nil,
        middle_mouse_command = "bdelete! %d",
        style_preset = bufferline.style_preset.no_italic,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        always_show_bufferline = true,
    }
}

require("which-key").register({
    ["<C-l>"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer Next" },
    ["<C-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer Prev" },
    ["<C-d>"] = { "<cmd>bd<cr>", "Unload Buffer" },
}, { })
