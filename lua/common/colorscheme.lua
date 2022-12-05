local themer = requirePlugin "themer"

local tui_color = function(t, config)
  if t then
    t.setup {
      colorscheme = config.colorscheme or "everforest",
      transparent = config.transparent or false,
      styles = {
        keyword = { style = config.keyword or "italic" },
        keywordBuiltIn = { style = config.keywordBuiltIn or "italic" },
      },
    }
  end
end

if themer then
  local parser = require "utils.parser"
  local ok, json =
    parser:parse(vim.api.nvim_list_runtime_paths()[1] .. "/config.json")
  if ok then
    tui_color(themer, json)
  end
end
