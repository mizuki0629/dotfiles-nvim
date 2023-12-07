local ensure_installed = {
    "lua_ls",
    "rust_analyzer",
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
    ensure_installed = ensure_installed
})

local lsphandlers = require("plugin.lsphandlers")
require("mason-lspconfig").setup_handlers({
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = lsphandlers.on_attach,
            flags = lsphandlers.lsp_flags,
            capabilities = lsphandlers.capabilities,
        })
    end,

    lua_ls = function()
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
    end,
    rust_analyzer = function()
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
    end,
})
