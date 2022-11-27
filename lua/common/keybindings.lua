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
-- map("v", "[", "<gv", opt)
-- map("v", "]", ">gv", opt)

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

local PLUGIN_KEYS = {}

PLUGIN_KEYS.nvim_tree_keys = {
  { key = ".", action = "toggle_dotfiles" },
}

PLUGIN_KEYS.telescope_keys = {
  i = {
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
  },
  n = {
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
  },
}

PLUGIN_KEYS.map_lsp = function(buf)
  -- buf("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  buf("n", "K", "<cmd>Lspsaga hover_doc<CR>", opt)
  -- buf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  -- buf("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions({ initial_mode = 'normal', })<CR>", opt)
  buf("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opt)
  buf("n", "gi", "<cmd>LSoutlineToggle<CR>", opt)
  buf("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opt)
  -- buf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- buf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- buf("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references({ initial_mode = 'normal' })<CR>", opt)
  -- buf("n", "<localleader>d", "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>", opt)
  buf("n", "<localleader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  buf("n", "<localleader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opt)
  buf("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt)
  buf("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt)
end

PLUGIN_KEYS.map_ts_util = function(buf)
  buf("n", "<leader>gs", "<cmd>TSLspOrganize<CR>", opt)
  buf("n", "<leader>gr", "<cmd>TSLspRenameFile<CR>", opt)
  buf("n", "<leader>gi", "<cmd>TSLspImportAll<CR>", opt)
end

PLUGIN_KEYS.cmp = function(c)
  local feed_key = function(key, mode)
    local keys = vim.api.nvim_replace_termcodes(key, true, true, true) or ""
    vim.api.nvim_feedkeys(keys, mode, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  return {
    ["<A-.>"] = c.mapping(c.mapping.complete(), { "i", "c" }),
    ["<A-,>"] = c.mapping {
      i = c.mapping.abort(),
      c = c.mapping.close(),
    },
    ["<C-p>"] = c.mapping.select_prev_item(),
    ["<C-n>"] = c.mapping.select_next_item(),
    ["<C-e>"] = c.mapping {
      i = c.mapping.abort(),
      c = c.mapping.close(),
    },
    ["<CR>"] = c.mapping.confirm {
      select = true,
    },
    ["<Tab>"] = c.mapping(function(fallback)
      if c.visible() then
        c.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feed_key("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        c.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = c.mapping(function()
      if c.visible() then
        c.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feed_key("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }
end

PLUGIN_KEYS.comment = {
  opleader = {
    line = "gc",
    bock = "gb",
  },
}

PLUGIN_KEYS.map_dap = function()
  map("n", "<leader>ds", "<cmd>RustDebuggables<CR>", opt)
  map(
    "n",
    "<leader>dq",
    "<cmd>lua require'dap'.close()<CR>"
      .. ":lua require'dap'.terminate()<CR>"
      .. ":lua require'dap.repl'.close()<CR>"
      .. ":lua require'dapui'.close()<CR>"
      .. ":lua require('dap').clear_breakpoints()<CR>"
      .. "<C-w>o<CR>",
    opt
  )
  map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opt)
  map("n", "<leader>dp", ":lua require'dap'.toggle_breakpoint()<CR>", opt)
  map("n", "<leader>dP", ":lua require'dap'.clear_breakpoints()<CR>", opt)
  map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>", opt)
  map("n", "<leader>do", ":lua require'dap'.step_out()<CR>", opt)
  map("n", "<leader>di", ":lua require'dap'.step_into()<CR>", opt)
  map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)
end

return PLUGIN_KEYS
