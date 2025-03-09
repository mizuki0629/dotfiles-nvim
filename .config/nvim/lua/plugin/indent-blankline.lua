require("ibl").setup({})

local highlight = {
    "Rainbow1",
    "Rainbow2",
    "Rainbow3",
    "Rainbow4",
    "Rainbow5",
    -- "Rainbow6",
    -- "Rainbow7",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
local colors = require("nord.colors")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Rainbow1", { fg = colors.palette.aurora.red })
    vim.api.nvim_set_hl(0, "Rainbow2", { fg = colors.palette.aurora.orange })
    vim.api.nvim_set_hl(0, "Rainbow3", { fg = colors.palette.aurora.yellow })
    vim.api.nvim_set_hl(0, "Rainbow4", { fg = colors.palette.aurora.green })
    vim.api.nvim_set_hl(0, "Rainbow5", { fg = colors.palette.aurora.purple })
    -- vim.api.nvim_set_hl(0, "Rainbow6", { fg = colors.palette.aurora.red })
    -- vim.api.nvim_set_hl(0, "Rainbow7", { fg = colors.palette.aurora.red })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup({ scope = { highlight = highlight } })

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
