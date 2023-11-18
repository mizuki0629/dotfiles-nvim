require("toggleterm").setup({
})

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

require("which-key").register({
    t = {
        name = "toggleterm",
        t = { "<cmd>ToggleTerm direction=float<CR>", "toggle terminal" },
        g = { "<cmd>lua _lazygit_toggle()<CR>", "lazygit" },
    },
}, { prefix = "<leader>" })
