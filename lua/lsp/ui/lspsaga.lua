local sage = requirePlugin "lspsaga"
if sage then
  sage.init_lsp_saga {
    symbol_in_winbar = {
      in_custom = false,
      enable = false,
      separator = " ",
      -- show_file = true,
      -- define how to customize filename, eg: %:., %
      -- if not set, use default value `%:t`
      -- more information see `vim.fn.expand` or `expand`
      -- ## only valid after set `show_file = true`
      file_formatter = "",
      click_support = false,
    },
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    show_outline = {
      win_position = "right",
      --set special filetype win that outline window split.like NvimTree neotree
      -- defx, db_ui
      win_with = "",
      win_width = 30,
      auto_enter = false,
      auto_preview = true,
      virt_text = "┃",
      jump_key = "o",
      -- auto refresh when change buffer
      auto_refresh = true,
    },
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
    finder_request_timeout = 2000,
    finder_action_keys = {
      open = { "o", "<CR>" },
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
    },
    rename_action_quit = "<C-c>",
    rename_in_select = true,
  }
end

--[[ local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name {}
  if vim.fn.bufname "%" == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand "%:~:.:h", "%%", ""), sep, { plain = true })
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar_or_statusline()
  local exclude = {
    ["terminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["help"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
    local sym
    if ok then
      sym = lspsaga.get_symbol_node()
    end
    local win_val = get_file_name(true) -- set to true to include path
    if sym ~= nil then
      win_val = win_val .. sym
    end
    vim.wo.winbar = win_val
    -- if work in statusline
    -- vim.wo.stl = win_val
  end
end

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

vim.api.nvim_create_autocmd(events, {
  pattern = "*",
  callback = function()
    config_winbar_or_statusline()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LspsagaUpdateSymbol",
  callback = function()
    config_winbar_or_statusline()
  end,
}) ]]
