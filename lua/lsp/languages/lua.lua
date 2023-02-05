local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
}

return {
  on_setup = function(server)
    require("neodev").setup { lspconfig = opts }
    server.setup(opts)
  end,
}
