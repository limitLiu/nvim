require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

local lsp_config = require "lspconfig"

local servers = {
  sumneko_lua = require "lsp.languages.lua",
  rust_analyzer = require "lsp.languages.rust",
  clangd = require "lsp.languages.clang",
  -- hls = {},
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
