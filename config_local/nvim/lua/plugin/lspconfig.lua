require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ansiblels", "gopls" 
    }
})
local lsphandlers = require("plugin.lsphandlers")

require("lspconfig").lua_ls.setup({
    on_attach = lsphandlers.on_attach,
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

require("lspconfig").jedi_language_server.setup({
    on_attach = lsphandlers.on_attach,
    flags = lsphandlers.lsp_flags,
    capabilities = lsphandlers.capabilities,
})

require("lspconfig").rust_analyzer.setup({
    on_attach = lsphandlers.on_attach,
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

require("lspconfig").ansiblels.setup({
    on_attach = lsphandlers.on_attach,
    flags = lsphandlers.lsp_flags,
    capabilities = lsphandlers.capabilities,
})

require("lspconfig").gopls.setup({
    on_attach = lsphandlers.on_attach,
    flags = lsphandlers.lsp_flags,
    capabilities = lsphandlers.capabilities,
})
