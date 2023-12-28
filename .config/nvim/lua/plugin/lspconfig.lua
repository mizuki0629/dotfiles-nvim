local lsphandlers = require("plugin.lsphandlers")

require("lspconfig").lua_ls.setup({
    on_attach = lsphandlers.on_attach({ is_format_on_save = true }),
    flags = lsphandlers.lsp_flags,
    capabilities = lsphandlers.capabilities,
    settings = {
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
    },
})

require("lspconfig").rust_analyzer.setup({
    on_attach = lsphandlers.on_attach({ is_format_on_save = true }),
    flags = lsphandlers.lsp_flags,
    capabilities = lsphandlers.capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            procMacro = {
                enable = true,
            },
        },
    },
})

if vim.fn.executable("go") == 1 then
    lsphandlers.default_handler("gopls")
end

if vim.fn.executable("ansible") == 1 then
    lsphandlers.default_handler("ansiblels")
end

if vim.fn.executable("python") == 1 then
    lsphandlers.default_handler("pyright")
end
