local common = require "lsp.languages.common"
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(_, buf)
    common.keybinding(buf)
  end,
  handlers = common.handlers,
  settings = {
    formatterMode = "typstyle",
  },
}
return opts
