local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
  end,
}

opts.capabilities.offsetEncoding = { "utf-16" }

return {
  on_setup = function(server)
    local clangd_extensions = requirePlugin "clangd_extensions"
    if not clangd_extensions then
      server.setup(opts)
    else
      clangd_extensions.setup {
        server = opts,
      }
    end
  end,
}
