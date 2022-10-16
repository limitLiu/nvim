local common = require "lsp.languages.common"
local ts_utils = requirePlugin "nvim-lsp-ts-utils"
local keybindings = requirePlugin "common.keybindings"

local opts = {}

if ts_utils and keybindings then
  opts = {
    capabilities = common.capabilities,
    flags = common.flags,
    on_attach = function(client, buf)
      common.disableFormat(client)
      common.keybinding(buf)
      ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        -- import all
        import_all_timeout = 5000, -- ms
        -- lower numbers = higher priority
        import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4, -- loaded buffer names
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
        -- if false will avoid organizing imports
        always_organize_imports = true,
        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},
        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = "Comment",
        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
      }
      ts_utils.setup_client(client)
      common.tsKeybinding(buf, keybindings)
    end,
  }
end

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
