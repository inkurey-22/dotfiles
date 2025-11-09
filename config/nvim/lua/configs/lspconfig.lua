require("nvchad.configs.lspconfig").defaults()

local servers = { "zls", "html", "cssls", "clangd", "clang-format", "rust_analyzer" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
