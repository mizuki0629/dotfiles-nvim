local signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn",  text = " " },
    { name = "DiagnosticSignHint",  text = " " },
    { name = "DiagnosticSignInfo",  text = " " },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = true, -- disable virtual text
    signs = {
        active = signs, -- show signs
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function lsp_keymaps(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    require("which-key").register({
        ["<leader>"] = {
            D = { vim.lsp.buf.type_definition, "Type Definition" },
            rn = { vim.lsp.buf.rename, "Rename" },
            l = {
                name = "LSP",
                D = { vim.lsp.buf.declaration, "Declaration" },
                d = { vim.lsp.buf.definition, "Definition" },
                i = { vim.lsp.buf.implementation, "Implementation" },
                R = { vim.lsp.buf.rename, "Rename" },
                r = { vim.lsp.buf.references, "References" },
                h = { vim.lsp.buf.signature_help, "Help LSP" },
                f = {
                    function()
                        vim.lsp.buf.format({ async = true })
                    end,
                    "Format",
                },
            },
            w = {
                name = "Workspace",
                a = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
                r = { vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    "Print Workspace Folers",
                },
            },
            ca = { vim.lsp.buf.code_action, "Code Action" },
        },
        K = { vim.lsp.buf.hover, "Hover LSP" },
    }, { noremap = true, silent = true, buffer = bufnr })
end

-- Use an on_attach function to only map the following keys
local function on_attach(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)

    -- Format on save
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    capabilities = capabilities,
    lsp_flags = lsp_flags,
    on_attach = on_attach,
}
