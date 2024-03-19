local common = require "lsp.languages.common"
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
  handlers = common.handlers,
  init_options = {
    extensionConfiguration = {
      askToStartBuild = false,
      signatureHelp = { enabled = true },
      inlayHints = { enable = true },
      autoRunCodeAnalysis = true,
      codeLens = true,
    },
  },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
