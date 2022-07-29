local opts = {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, buf)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local function buf_set_map(...)
      vim.api.nvim_buf_set_keymap(buf, ...)
    end
    require("common.keybindings").map_lsp(buf_set_map)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
