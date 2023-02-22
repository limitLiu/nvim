require("mason").setup {}
require("mason-lspconfig").setup {}

local lsp_config = require "lspconfig"

local servers = {
  lua_ls = require "lsp.languages.lua",
  rust_analyzer = require "lsp.languages.rust",
  clangd = require "lsp.languages.clangd",
  jdtls = require "lsp.languages.java",
  gopls = require "lsp.languages.go",
  html = require "lsp.languages.html",
  cssls = require "lsp.languages.css",
  jsonls = require "lsp.languages.json",
  tsserver = require "lsp.languages.ts",
  phpactor = require "lsp.languages.php",
  kotlin_language_server = require "lsp.languages.kotlin",
  ocamllsp = require "lsp.languages.ocaml",
  rescriptls = require "lsp.languages.rescript",
  rnix = require "lsp.languages.nix",
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
