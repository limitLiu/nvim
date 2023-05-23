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
map("i", "<C-a>", "<C-o>I", opt)

map("v", "v", "<Esc>", opt)
-- map("v", "[", "<gv", opt)
-- map("v", "]", ">gv", opt)

map("n", "<A-]>", "<C-w>+", opt)
map("n", "<A-[>", "<C-w>-", opt)
map("n", "<A-h>", "<C-w><", opt)
map("n", "<A-l>", "<C-w>>", opt)

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opt)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opt)
map("t", "<leader>tt", "<C-\\><C-n><cmd>Lspsaga term_toggle<CR>", opt)

map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-h>", "<C-w>h", opt)

local M = {}

M.telescope_keys = {
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

M.map_lsp = function(buf)
  buf("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  -- buf("n", "K", "<cmd>Lspsaga hover_doc<CR>", opt)
  buf("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opt)
  buf("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opt)
  buf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
  buf("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt)
  buf("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt)
  buf("n", "<localleader>dw", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opt)
  buf("n", "<localleader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  buf(
    "n",
    "<localleader>dd",
    "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>",
    opt
  )
  buf("n", "<leader>lc", "<cmd>Lspsaga code_action<CR>", opt)
end

M.map_flutter_tools = function(buf)
  buf("n", "<leader>ac", "<cmd>Telescope flutter commands<CR>", opt)
end

M.map_ts_util = function(buf)
  buf("n", "<localleader>gs", "<cmd>TSLspOrganize<CR>", opt)
  buf("n", "<localleader>gr", "<cmd>TSLspRenameFile<CR>", opt)
  buf("n", "<localleader>gi", "<cmd>TSLspImportAll<CR>", opt)
end

M.cmp = function(c)
  local feed_key = function(key, mode)
    local keys = vim.api.nvim_replace_termcodes(key, true, true, true) or ""
    vim.api.nvim_feedkeys(keys, mode, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match "%s"
        == nil
  end

  return {
    ["<A-.>"] = c.mapping(c.mapping.complete(), { "i", "c" }),
    ["<A-,>"] = c.mapping {
      i = c.mapping.abort(),
      c = c.mapping.close(),
    },
    ["<C-p>"] = c.mapping.select_prev_item(),
    ["<C-n>"] = c.mapping.select_next_item(),
    -- ["<C-e>"] = c.mapping {
    --   i = c.mapping.abort(),
    --   c = c.mapping.close(),
    -- },
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

M.comment = {
  opleader = {
    line = "gc",
    bock = "gb",
  },
}

M.map_dap = function()
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
  map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opt)
  map("n", "<leader>dp", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opt)
  map("n", "<leader>dP", "<cmd>lua require'dap'.clear_breakpoints()<CR>", opt)
  map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", opt)
  map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", opt)
  map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opt)
  map("n", "<leader>dh", "<cmd>lua require'dapui'.eval()<CR>", opt)
end

return M
