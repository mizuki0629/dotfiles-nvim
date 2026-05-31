local ts = require("nvim-treesitter")
ts.setup({})
ts.install({
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "regex",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype

        -- 必要なら無効化
        if ft == "yaml" then
            return
        end

        pcall(vim.treesitter.start, args.buf)

        -- treesitter fold を使うなら
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
    end,
})
