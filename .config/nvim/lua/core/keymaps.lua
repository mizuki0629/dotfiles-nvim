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
