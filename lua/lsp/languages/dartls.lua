local common = require "lsp.languages.common"
local keybindings = require "common.keybindings"

local opts = {
  handlers = common.handlers,
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.keybinding(buf)
    common.flutterKeybinding(buf, keybindings)
  end,
}

local telescopeOk, telescope = pcall(require, "telescope")
if telescopeOk then
  telescope.load_extension "flutter"
end

return {
  on_setup = function(server)
    local ok, flutter_tools = pcall(require, "flutter-tools")
    if not ok then
      server.setup(opts)
    else
      flutter_tools.setup {
        lsp = opts,
        ui = {
          border = "single",
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            device = true,
          },
        },
        fvm = true,
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
      }
    end
  end,
}
