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
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

return {
  on_setup = function(server)
    local rust_tools = requirePlugin "rust-tools"
    if not rust_tools then
      server.setup(opts)
    else
      rust_tools.setup {
        server = opts,
        dap = require "lsp.dap.nvim-dap.rust",
      }
    end
  end,
}
