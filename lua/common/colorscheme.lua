local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")

require("catppuccin").setup {
  flavour = "latte", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = { "bold" },
    functions = {},
    keywords = { "italic" },
    strings = {},
    variables = {},
    numbers = {},
    booleans = { "bold" },
    properties = {},
    types = { "bold" },
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
}

vim.g.everforest_enable_italic = true
vim.g.everforest_background = json.background or "Medium"
vim.o.background = json.dark or "light"
vim.g.everforest_better_performance = true
local color = json.colorscheme or "everforest"
local ok, _ = pcall(vim.cmd, "colorscheme " .. color)
pcall(vim.cmd, "set termguicolors")
if not ok then
  vim.notify("Failed to find colorscheme " .. color)
  return
end
