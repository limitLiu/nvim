-- vim.o.background = "dark"
-- require("onedark").setup({
--   colors = { hint = "orange0", error = "#ff0000" },
--   keyword_style = "italic",
-- })

-- vim.o.background = "light"
-- local color = 'everforest'

local is_gui = os.getenv "NVIM_GUI"
if is_gui == '1' then
  local monokai = requirePlugin "monokai"
  if monokai then
    monokai.setup {
      italics = false,
    }
  end
else
  local gruvbox = requirePlugin "gruvbox"
  if gruvbox then
    gruvbox.setup {
      bold = true,
      italic = true,
    }
    vim.o.background = "dark"
    local color = "gruvbox"
    local ok, _ = pcall(vim.cmd, "colorscheme " .. color)
    pcall(vim.cmd, "set termguicolors")
    if not ok then
      vim.notify("Cannot find colorscheme " .. color)
      return
    end
  end
end
