vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("i", "kj", "<Esc>", opt)
map("i", "jk", "<Esc>", opt)
map("i", "kk", "<Esc>", opt)
map("i", "jj", "<Esc>", opt)

map("i", "<C-f>", "<Right>", opt)
map("i", "<C-b>", "<Left>", opt)
map("i", "<C-e>", "<End>", opt)
map("i", "<C-a>", "<Home>", opt)

map("v", "v", "<Esc>", opt)
map("v", "]", ">gv", opt)
map("v", "[", "<gv", opt)

local plugKeys = {}

plugKeys.comment = {
  opleader = {
    line = "gc",
    bock = "gb",
  },
}

plugKeys.cmp = function(c)
  return {
    ["<S-Tab>"] = c.mapping.select_prev_item(),
    ["<Tab>"] = c.mapping.select_next_item(),
    ["<C-e>"] = c.mapping {
      i = c.mapping.abort(),
      c = c.mapping.close(),
    },
    ["<CR>"] = c.mapping.confirm {
      select = true,
    },
  }
end

return plugKeys
