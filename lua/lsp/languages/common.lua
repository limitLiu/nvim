local M = {}

M.keybinding = function(buf)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  require("common.keybindings").map_lsp(buf_set_map)
end

M.tsKeybinding = function(buf, keybindings)
  local function buf_set_map(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end
  keybindings.map_ts_util(buf_set_map)
end

M.disableFormat = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.flags = {
  debounce_text_changes = 150,
}

return M
