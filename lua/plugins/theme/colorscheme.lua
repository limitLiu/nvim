local config = require "config"

local color = config.colorscheme or "everforest"
vim.cmd.colorscheme(color)
local background = config.background or "dark"
vim.o.background = background
vim.g.python3_host_prog = config.python3_host_prog or "/usr/bin/python3"
