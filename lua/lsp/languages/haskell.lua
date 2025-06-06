local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(_client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
}

return opts
