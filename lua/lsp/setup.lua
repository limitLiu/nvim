require("mason").setup {
  log_level = vim.log.levels.ERROR,
}

local servers = {
  lua_ls = require "lsp.languages.lua",
  -- rust_analyzer = require "lsp.languages.rust",
  clangd = require "lsp.languages.clangd",
  jsonls = require "lsp.languages.json",
  ocamllsp = require "lsp.languages.ocaml",
  hls = require "lsp.languages.haskell",
  sourcekit = require "lsp.languages.swift",
  rescriptls = require "lsp.languages.rescript",
  zls = require "lsp.languages.zig",
  cssls = require "lsp.languages.css",
}

for key, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    vim.lsp.enable(key)
    vim.lsp.config(key, config)
  end
end
