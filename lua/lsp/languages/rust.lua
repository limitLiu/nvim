local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      inlayHints = { locationLinks = false },
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
