local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")

local color = json.colorscheme
vim.g.colors_name = color
vim.opt.termguicolors = true
vim.schedule(function()
  vim.o.background = json.background or "dark"
end)

-- vim.cmd [[
-- set guifont=iMWritingMonoS\ Nerd\ Font:h16
-- ]]
vim.opt.guifont = {
  json.font or "DMMono Nerd Font",
  ":h" .. tostring(json.font_size or 16),
}

vim.g.python3_host_prog = json.python3_host_prog or "/opt/local/bin/python3"
