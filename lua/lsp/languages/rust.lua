local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common:rustKeybinding(buf)
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

local hover_actions = {
  border = common.border,
  -- Maximal width of the hover window. Nil means no max.
  max_width = nil,

  -- Maximal height of the hover window. Nil means no max.
  max_height = nil,

  -- whether the hover action window gets automatically focused
  -- default: false
  auto_focus = false,
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
        tools = {
          hover_actions = hover_actions,
        },
      }
    end
  end,
}
