local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")

local color = json.colorscheme or "everforest"
vim.g.colors_name = color
vim.opt.termguicolors = true
vim.schedule(function()
  vim.o.background = json.background or "dark"
end)

-- vim.cmd [[
-- set guifont=iMWritingMonoS\ Nerd\ Font:h16
-- ]]
vim.opt.guifont = {
  json.font or "iMWritingMonoS Nerd Font",
  ":h" .. tostring(json.font_size or 16),
}
