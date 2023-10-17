local M = {}

M.keybinding = function(buf)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  require("common.keybindings").map_lsp(buf_set_map)
end

M.disableFormat = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.flutterKeybinding = function(buf, keybindings)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  keybindings.map_flutter_tools(buf_set_map)
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
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = M.border }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = M.border }
  ),
}

return M
