local config = require "common.config"
vim.opt.termguicolors = true

vim.schedule(function()
  local color = config.colorscheme
  vim.g.colors_name = color
  -- vim.cmd("set background=" .. config.background)
  vim.o.background = config.background or "dark"
  vim.g.python3_host_prog = config.python3_host_prog or "/opt/local/bin/python3"
end)
