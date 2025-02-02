require("toggleterm").setup({})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    hidden = true,
    close_on_exit = true,
    -- on_open = function(term)
    --     vim.cmd("startinsert!")
    --     vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    -- end,
    -- on_close = function(term)
    --     vim.cmd("startinsert!")
    -- end,
})

function _lazygit_toggle()
    lazygit:toggle()
end

require("which-key").add({
    { "<leader>t",  group = "toggleterm" },
    { "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>",      desc = "lazygit" },
    { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "toggle terminal" },
})
