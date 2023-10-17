local common = require "lsp.languages.common"
local keybindings = requirePlugin "common.keybindings"

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

local telescope = requirePlugin "telescope"
if telescope then
  telescope.load_extension "flutter"
end

return {
  on_setup = function(server)
    local flutter_tools = requirePlugin "flutter-tools"
    if not flutter_tools then
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
