local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")

require("catppuccin").setup {
  flavour = "frappe", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "macchiato",
  },
  transparent_background = true,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = true,
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
    functions = { "bold" },
    keywords = { "italic" },
    strings = { "bold" },
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

local color = json.colorscheme or "everforest"
vim.g.colors_name = color
vim.opt.termguicolors = true
vim.schedule(function()
  vim.o.background = json.dark or "dark"
end)

if color == "everforest" then
  vim.g.everforest_enable_italic = true
  vim.g.everforest_background = json.background or "Medium"
  -- vim.g.everforest_better_performance = true
end

-- vim.cmd [[
-- set guifont=iMWritingMonoS\ Nerd\ Font:h16
-- ]]
vim.opt.guifont = {
  json.font or "iMWritingMonoS Nerd Font",
  ":h" .. tostring(json.font_size or 16),
}
