local M = {}

M.config_values = {
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  -- diagnostic_header_icon = "   ",
  diagnostic_header_icon = " ",
  use_diagnostic_virtual_text = true,
  -- diagnostic_show_source = true,
  -- diagnostic_show_code = true,
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "<CR>",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<Esc>",
    exec = "<CR>",
  },
  rename_prompt_populate = true,
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  definition_preview_icon = "  ",
  border_style = "single",
  -- rename_prompt_prefix = "➤",
  rename_prompt_prefix = "",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}

M.config_values.dianostic_header_icon = M.config_values.diagnostic_header_icon

local extend_config = function(opts)
  opts = opts or {}
  if next(opts) == nil then
    return
  end
  for key, value in pairs(opts) do
    if M.config_values[key] == nil then
      error(string.format("[LspSaga] Key %s not exist in config values", key))
      return
    end
    if type(M.config_values[key]) == "table" then
      for k, v in pairs(value) do
        M.config_values[key][k] = v
      end
    else
      M.config_values[key] = value
    end
  end
end

M.init_lsp_saga = function(opts)
  extend_config(opts)
  local config = M.config_values

  if config.use_saga_diagnostic_sign then
    for type, icon in pairs {
      Error = config.error_sign,
      Warn = config.warn_sign,
      Hint = config.hint_sign,
      Info = config.infor_sign,
    } do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
      })
    end
  end

  if config.code_action_prompt.enable then
    require("lsp.ui.lspsaga.codeaction.indicator").attach()
  end

  vim.diagnostic.config {
    virtual_text = config.use_diagnostic_virtual_text,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  }

  vim.api.nvim_create_user_command("Lspsaga", function(args)
    require("lsp.ui.lspsaga.command").load_command(unpack(args.fargs))
  end, {
    range = true,
    nargs = "+",
    complete = function(arg)
      local list = require("lsp.ui.lspsaga.command").command_list()
      return vim.tbl_filter(function(s)
        return string.match(s, "^" .. arg)
      end, list)
    end,
  })
end

M.setup = M.init_lsp_saga

return M
