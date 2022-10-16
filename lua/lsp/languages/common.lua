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
  if vim.fn.has "nvim-0.7" == 1 then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  else
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.flags = {
  debounce_text_changes = 150,
}

return M
