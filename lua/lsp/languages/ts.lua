local ts_utils = requirePlugin "nvim-lsp-ts-utils"
local keybindings = requirePlugin "common.keybindings"

local opts = {}

if ts_utils and keybindings then
  opts = {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = function(client, buf)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      local function buf_set_map(...)
        vim.api.nvim_buf_set_keymap(buf, ...)
      end
      keybindings.map_lsp(buf_set_map)
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
      keybindings.map_ts_util(buf_set_map)
    end,
  }
end

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
