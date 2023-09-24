local common = require "lsp.languages.common"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  handlers = common.handlers,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
    local ok, inlay_hints = pcall(require, "clangd_extensions.inlay_hints")
    if ok then
      inlay_hints.setup_autocmd()
      inlay_hints.set_inlay_hints()
    end
  end,
}

opts.capabilities.offsetEncoding = { "utf-16" }

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
