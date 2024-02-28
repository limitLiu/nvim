local config = require "config"
vim.opt.termguicolors = true

vim.schedule(function()
  local color = config.colorscheme or "everforest"
  vim.g.colors_name = color
  vim.o.background = config.background or "dark"
  vim.g.python3_host_prog = config.python3_host_prog or "/usr/bin/python3"
end)
