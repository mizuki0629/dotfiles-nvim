local signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn", text = " " },
    { name = "DiagnosticSignHint", text = " " },
    { name = "DiagnosticSignInfo", text = " " },
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

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = "rounded",
-- })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--     border = "rounded",
-- })

local function lsp_keymaps(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    require("which-key").add({
        -- LSP General Group
        { "<leader>l", group = "LSP" },
        {
            "<leader>lD",
            vim.lsp.buf.declaration,
            desc = "LSP Declaration",
        },
        {
            "<leader>ld",
            vim.lsp.buf.definition,
            desc = "LSP Definition",
        },
        {
            "<leader>li",
            vim.lsp.buf.implementation,
            desc = "LSP Implementation",
        },
        { "<leader>lR", vim.lsp.buf.rename, desc = "LSP Rename" },
        {
            "<leader>lr",
            vim.lsp.buf.references,
            desc = "LSP References",
        },
        {
            "<leader>lh",
            vim.lsp.buf.signature_help,
            desc = "LSP Signature Help",
        },
        {
            "<leader>lf",
            function()
                vim.lsp.buf.format({ async = true })
            end,
            desc = "LSP Format",
        },

        -- Workspace Management Group
        { "<leader>lw", group = "Workspace" },
        {
            "<leader>lwa",
            vim.lsp.buf.add_workspace_folder,
            desc = "Add Workspace Folder",
        },
        {
            "<leader>lwr",
            vim.lsp.buf.remove_workspace_folder,
            desc = "Remove Workspace Folder",
        },
        {
            "<leader>lwl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = "List Workspace Folders",
        },

        -- Other LSP mappings
        {
            "<leader>ca",
            vim.lsp.buf.code_action,
            desc = "Code Action",
        },
        { "K", vim.lsp.buf.hover, desc = "Hover LSP" },
    })
end

-- Use an on_attach function to only map the following keys
local function on_attach(args)
    return function(client, bufnr)
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "sumneko_lua" then
            client.server_capabilities.documentFormattingProvider = false
        end

        lsp_keymaps(bufnr)

        -- Format on save
        if args["is_format_on_save"] then
            vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
        end

        -- local status_ok, illuminate = pcall(require, "illuminate")
        -- if not status_ok then
        --     error("Failed to load illuminate" .. illuminate)
        --     return
        -- end
        -- illuminate.on_attach(client)
    end
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function default_handler(server_name)
    require("lspconfig")[server_name].setup({
        on_attach = on_attach({ is_format_on_save = true }),
        flags = lsp_flags,
        capabilities = capabilities,
    })
end

local function make_handler(settings)
    return function(server_name)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach({ is_format_on_save = true }),
            flags = lsp_flags,
            capabilities = capabilities,
            settings = settings,
        })
    end
end

return {
    capabilities = capabilities,
    lsp_flags = lsp_flags,
    on_attach = on_attach,
    default_handler = default_handler,
    make_handler = make_handler,
}
