-- vim.o.background = "dark"
-- require("onedark").setup({
--   colors = { hint = "orange0", error = "#ff0000" },
--   keyword_style = "italic",
-- })

-- vim.o.background = "light"
-- local color = 'everforest'

local gui_color = function(themer)
  if themer then
    themer.setup {
      colorscheme = "rose_pine_dawn",
      transparent = false,
      styles = {
        ["function"] = { style = "italic" },
        functionbuiltin = { style = "italic" },
        variable = { style = "italic" },
        variableBuiltIn = { style = "italic" },
        parameter = { style = "italic" },
      },
    }
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
end

local tui_color = function(themer)
  if themer then
    themer.setup {
      colorscheme = "everforest_light",
      -- transparent = true,
      styles = {
        keyword = { style = "italic" },
        keywordBuiltIn = { style = "italic" },
      },
    }
  end
end

local themer = requirePlugin "themer"
local is_gui = os.getenv "NVIM_GUI"
if is_gui == "1" then
  gui_color(themer)
else
  tui_color(themer)
end
