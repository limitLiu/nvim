local parser = require "utils.parser"
local _, json =
  parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")
vim.o.background = json.background or "light"
local color = json.colorscheme or "everforest"
local ok, _ = pcall(vim.cmd, "colorscheme " .. color)
pcall(vim.cmd, "set termguicolors")
if not ok then
  vim.notify("Failed to find colorscheme " .. color)
  return
end
