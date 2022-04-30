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
plugKeys.map_lsp = function(buf)
  buf("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  buf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  buf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  buf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  buf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  buf("n", "<localleader>d", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", opt)
end

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
    ["<C-e>"] = c.mapping({
      i = c.mapping.abort(),
      c = c.mapping.close(),
    }),
    ["<CR>"] = c.mapping.confirm({
      select = true,
    }),
  }
end

return plugKeys
