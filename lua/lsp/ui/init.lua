-- auto show diagnostic message
-- vim.o.updatetime = 350
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
local M = {}

local lspKindOk, lspkind = pcall(require, "lspkind")
if lspKindOk then
  local ok, _ = pcall(require, "nvim-cmp")

  if ok then
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
end

local ok, lspsaga = pcall(require, "lspsaga")
if ok then
  lspsaga.setup {
    ui = {
      border = "single",
    },
    symbol_in_winbar = { enable = false },
    diagnostic = { border_follow = false },
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
