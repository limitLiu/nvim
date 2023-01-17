local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")

local gruvbox = requirePlugin "gruvbox"
if gruvbox then
  gruvbox.setup {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  }
end

vim.o.background = json.background or "light"
local color = json.colorscheme or "everforest"
local ok, _ = pcall(vim.cmd, "colorscheme " .. color)
pcall(vim.cmd, "set termguicolors")
if not ok then
  vim.notify("Failed to find colorscheme " .. color)
  return
end
