-- auto show diagnostic message
-- vim.o.updatetime = 350
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
local M = {}

local lspKindOk, lspkind = pcall(require, "lspkind")
if lspKindOk then
  lspkind.init {}
  local ok, _ = pcall(require, "cmp")

  if ok then
    M.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = lspkind.cmp_format {
        mode = "symbol",
        maxwidth = 50,
        before = function(entry, vim_item)
          local source = entry.source.name
          local s = ({
            nvim_lsp = "lsp",
          })[source]
          vim_item.menu = (s and { "[" .. s:upper():sub(1, 1) .. "]" } or {
            "[" .. source:upper():sub(1, 1) .. "]",
          })[1]
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
