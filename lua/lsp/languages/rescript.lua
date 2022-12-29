local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
  init_options = {
    extensionConfiguration = {
      askToStartBuild = false,
    },
  },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
