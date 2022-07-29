-- vim.o.background = "dark"
-- require("onedark").setup({
--   colors = { hint = "orange0", error = "#ff0000" },
--   keyword_style = "italic",
-- })

vim.o.background = "light"
local color = 'everforest'
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. color)
pcall(vim.cmd, 'set termguicolors')
if not ok then
  vim.notify('Cannot find colorscheme ' .. color)
  return
end
