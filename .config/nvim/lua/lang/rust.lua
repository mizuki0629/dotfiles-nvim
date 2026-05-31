vim.lsp.config["rust_analyzer"] = {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

vim.lsp.enable("rust_analyzer")
