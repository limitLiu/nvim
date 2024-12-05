local M = {}

M.keybinding = function(buf)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  require("common.keybindings").map_lsp(buf_set_map)
end

M.map_xcodebuild = function(buf)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  require("common.keybindings").map_xcodebuild(buf_set_map)
end

M.disableFormat = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities {
  snippetSupport = false,
}

M.flags = {
  debounce_text_changes = 150,
}

M.border = {
  { "┌", "highlight" },
  { "─", "highlight" },
  { "┐", "highlight" },
  { "│", "highlight" },
  { "┘", "highlight" },
  { "─", "highlight" },
  { "└", "highlight" },
  { "│", "highlight" },
}

M.handlers = {
  ["textDocument/hover"] = vim.lsp.buf.hover { border = M.border },
  ["textDocument/signatureHelp"] = vim.lsp.buf.signature_help {
    border = M.border,
  },
}

return M
