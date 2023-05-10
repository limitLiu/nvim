-- auto show diagnostic message
-- vim.o.updatetime = 350
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
local M = {}

local lspkind = requirePlugin "lspkind"
if lspkind then
  M.formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end,
    },
  }
end

local lspsaga = requirePlugin "lspsaga"
if lspsaga then
  lspsaga.setup {
    finder = {
      keys = {
        -- expand_or_jump = "<CR>",
      },
    },
  }
else
  vim.notify "Failed to load lspsaga."
end

return M
