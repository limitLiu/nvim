require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

local lsp_config = require "lspconfig"

local servers = {
  sumneko_lua = require "lsp.languages.lua",
  rust_analyzer = require "lsp.languages.rust",
  clangd = require "lsp.languages.clang",
  jdtls = require "lsp.languages.java",
  hls = require "lsp.languages.haskell",
  gopls = require "lsp.languages.go",
  html = require "lsp.languages.html",
  cssls = require "lsp.languages.css",
  emmet_ls = require "lsp.languages.emmet",
  jsonls = require "lsp.languages.json",
  tsserver = require "lsp.languages.ts",
}

for key, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    if config.on_setup then
      config.on_setup(lsp_config[key])
    end
  else
    lsp_config[key].setup {}
  end
end
