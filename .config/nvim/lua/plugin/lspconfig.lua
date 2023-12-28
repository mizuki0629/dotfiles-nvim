local ensure_installed = {
    "lua_ls",
}

if vim.fn.executable("go") == 1 then
    table.insert(ensure_installed, "gopls")
end

if vim.fn.executable("ansible") == 1 then
    table.insert(ensure_installed, "ansiblels")
end

if vim.fn.executable("python") == 1 then
    table.insert(ensure_installed, "pyright")
end

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
})

local lsphandlers = require("plugin.lsphandlers")
require("mason-lspconfig").setup_handlers({
    lsphandlers.default_handler,
    lua_ls = lsphandlers.make_handler({
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    }),
    rust_analyzer = lsphandlers.make_handler({
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            procMacro = {
                enable = true,
            },
        },
    }),
})
