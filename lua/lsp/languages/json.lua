local common = require "lsp.languages.common"

return {
  settings = {
    json = { schemas = require("schemastore").json.schemas() },
  },
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client)
    common.disableFormat(client)
  end,
}
