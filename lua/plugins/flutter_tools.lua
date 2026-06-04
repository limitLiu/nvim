local common = require "lsp.languages.common"

local opts = {
  handlers = common.handlers,
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, buf)
    common.disableFormat(client)
    common.flutterKeybinding(buf)
  end,
}

local telescopeOk, telescope = pcall(require, "telescope")
if telescopeOk then
  telescope.load_extension "flutter"
end

local ok, flutter_tools = pcall(require, "flutter-tools")
if ok then
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
