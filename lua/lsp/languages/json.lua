local common = require "lsp.languages.common"

return {
  on_setup = function(server)
    server.setup {
      settings = {
        json = { schemas = require("schemastore").json.schemas() },
      },
      capabilities = common.capabilities,
      flags = common.flags,
      on_attach = function(_)
        -- common.disableFormat(client)
      end,
    }
  end,
}
