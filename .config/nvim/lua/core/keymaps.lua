local noremap = function (lhs, rhs)
    vim.api.nvim_set_keymap('', lhs, rhs, { noremap = true })
end

local nnoremap = function (lhs, rhs)
    vim.keymap.set('n', lhs, rhs, {noremap = true})
end

-- dotfile
nnoremap(',.e', ':<C-u>edit '..vim.env.MYVIMRC..'<CR>')
nnoremap(',te', ':<C-u>tabnew '..vim.env.MYVIMRC..'<CR>')

-- ヘルプ
nnoremap('<M-h>', ':<C-u>h<Space>')
nnoremap('<C-h>', ':<C-u>vert<Space>h<Space>')

-- ; : swap
noremap(';', ':')
noremap(':', ';')
noremap('q;', 'q')
noremap('q:', 'q;')

-- 検索結果のハイライトを消す
nnoremap('<ESC><ESC>', ':nohlsearch<CR>')

-- Diagnostic Key Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local function git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle then
    local result = handle:read("*l")
    handle:close()
    return result
  end
end

local function open_codex_popup()
  local cwd = vim.fn.getcwd()
  local session = "codex-" .. vim.fn.system({ "sh", "-c", "printf %s " .. vim.fn.shellescape(cwd) .. " | md5sum | cut -c1-8" }):gsub("%s+", "")

  vim.fn.jobstart({
    "tmux",
    "has-session",
    "-t",
    session,
  }, {
    on_exit = function(_, code)
      if code ~= 0 then
        vim.fn.jobstart({
          "tmux",
          "new-session",
          "-d",
          "-s",
          session,
          "-d", cwd,
          "codex",
        })
      end

      vim.defer_fn(function()
        vim.fn.jobstart({
          "tmux",
          "display-popup",
          "-w", "90%",
          "-h", "90%",
          "-E",
          "tmux attach-session -t " .. session,
        })
      end, 100)
    end,
  })
end

local wk = require("which-key")

wk.add({
  -- グループ
  { "<leader>g", group = "Git" },
  { "<leader>r", group = "Run" },

  -- LazyGit
  {
    "<leader>gg",
    function()
      local root = vim.loop.cwd()
      vim.fn.jobstart({
        "tmux",
        "display-popup",
        "-E",
        "-d", root,
        "-w", "90%",
        "-h", "90%",
        "lazygit",
      })
    end,
    desc = "LazyGit (popup)",
  },

  -- 任意コマンド実行
  {
    "<leader>rr",
    function()
      local root = vim.loop.cwd()
      local cmd = vim.fn.input("Run: ")
      if cmd ~= "" then
        vim.fn.jobstart({
          "tmux",
          "display-popup",
          "-E",
          "-d", root,
          "-w", "90%",
          "-h", "90%",
          "bash", "-c", cmd .. "; read",
        })
      end
    end,
    desc = "Run command (popup)",
  },

 {
    "<leader>rj",
    function()
      local handle = io.popen("just --summary")
      if not handle then return end

      local result = handle:read("*a")
      handle:close()

      local tasks = {}
      for line in result:gmatch("%S+") do
        table.insert(tasks, line)
      end

      vim.ui.select(tasks, {
        prompt = "Select just task",
      }, function(choice)
        vim.notify("Selected task: " .. (choice or "None"))
        if not choice then return end
        vim.fn.jobstart({
          "tmux",
          "display-popup",
          "-E",
          "-w", "90%",
          "-h", "90%",
          "-d", vim.loop.cwd(),
          "bash", "-c", "just " .. choice .. "; read",
        })
      end)
    end,
    desc = "Just tasks",
  },
  { "<leader>a", group = "AI" },
  {
    "<leader>ac",
    open_codex_popup,
    desc = "Codex popup",
  },
})
