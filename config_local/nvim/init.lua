vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax on]])
vim.g.mapleader = " "
vim.opt.mouse = nil
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"
if vim.fn.executable("python3") and vim.fn.exists("/.dockerenv") == 0 then
    local venvpath = vim.fn.stdpath("data") .. "/venv"
    if not vim.loop.fs_stat(venvpath) then
        if vim.fn.has("linux") == 1 then
            vim.fn.system({
                "/usr/bin/env",
                "python3",
                "-m",
                "venv",
                venvpath,
            })
            vim.fn.system({
                venvpath .. "/bin/pip3",
                "install",
                "pynvim",
            })
        end
    end
    vim.g.python3_host_prog = venvpath .. "/bin/python"
end

require("plugin")
require("core.keymaps")
