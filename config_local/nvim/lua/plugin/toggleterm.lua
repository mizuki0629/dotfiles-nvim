require("toggleterm").setup()

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    hidden = true,
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
