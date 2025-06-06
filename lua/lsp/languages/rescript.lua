local common = require "lsp.languages.common"
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(_client, buf)
    -- common.disableFormat(client)
    common.keybinding(buf)
  end,
  handlers = common.handlers,
  settings = {
    rescript = {
      settings = {
        askToStartBuild = false,
        allowBuiltInFormatter = true, -- lower latency
        incrementalTypechecking = { -- removes the need for external build process
          enabled = true,
          acrossFiles = true,
        },
        cache = { projectConfig = { enabled = true } }, -- speed up latency dramatically
        codeLens = true,
        inlayHints = { enable = true },
      },
    },
  },
}
return opts
