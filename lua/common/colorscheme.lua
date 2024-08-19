local config = require "config"
vim.opt.termguicolors = true

vim.schedule(function()
  local color = config.colorscheme or "everforest"
  local background = config.background or "dark"
  if background == "dark" then
    vim.cmd.colorscheme(color)
  else
    vim.g.colors_name = color
  end
  vim.o.background = background
  vim.g.python3_host_prog = config.python3_host_prog or "/usr/bin/python3"
end)
