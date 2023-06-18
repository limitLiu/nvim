local wk = require "which-key"
local mapping = {
  [";"] = {
    "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    "Search Buffer",
  },
  a = {
    name = "Search",
    b = { "<cmd>Telescope buffers<CR>", "Search Buffer" },
    g = { "<cmd>Telescope live_grep<CR>", "Search Keyword" },
  },
  b = {
    name = "Buffer",
    k = { ":bw<CR>", "Kill Buffer" },
  },
  d = {
    name = "Debugger",
    s = { "Start" },
    q = { "Quit" },
    c = { "Continue" },
    p = { "Set BreakPoint" },
    P = { "Clear All BreakPoints" },
    j = { "Step Over" },
    o = { "Step Out" },
    i = { "Step Into" },
    h = { "Help" },
  },
  f = {
    name = "File",
    s = { ":update<CR>", "Save" },
    t = { "<cmd>NvimTreeToggle<CR>", "Toggle Tree" },
    r = { "<cmd>NvimTreeRefresh<CR>", "Tree Refresh" },
    d = { "<cmd>NvimTreeFocus<CR>", "Find Current File" },
    c = { "<cmd>NvimTreeCollapse<CR>", "Tree Collapse" },
  },
  g = {
    name = "gitsigns",
    b = { "Blame Line" },
    p = { "Preview Hunk" },
    S = { "Stage Buffer" },
    s = { "Stage Hunk" },
    t = { "Toggle Current Line Blame" },
    R = { "Reset Buffer" },
    d = { "Diff This" },
    u = { "Undo Stage Hunk" },
    x = { "Toggle Deleted" },
    r = { "Visual Reset Hunk" },
    D = { "Diff This ~" },
  },
  l = {
    name = "LSP",
    -- r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    r = { "<cmd>Lspsaga rename<CR>", "Rename" },
    c = { "Code Action" },
    o = { "<cmd>Lspsaga outline<CR>", "Toggle Outline" },
  },
  p = {
    name = "Projects",
    t = {
      "<cmd>Telescope projects<CR>",
      "Show Recent Projects",
    },
  },
  s = {
    name = "Search",
    c = { ":nohlsearch<CR>", "Clear Highlight Result" },
  },
  t = {
    name = "Terminal",
    t = { "<cmd>Lspsaga term_toggle<CR>", "Toggle Terminal" },
  },
  w = {
    name = "Window",
    h = { ":vsp<CR>", "Split Horizontal Window" },
    v = { ":sp<CR>", "Split Vertical Window" },
    c = { "<C-w>c", "Close Current Window" },
    o = { "<C-w>o", "Close Other Windows" },
    ["="] = { "<C-w>=", "Same Width Split Window" },
  },
}

local format = {
  "<cmd>lua vim.lsp.buf.format{ async = true }<CR>",
  "Formatting",
}

local localMapping = {
  -- p = { ":BufferLineCyclePrev<CR>", "Previous Buffer" },
  -- n = { ":BufferLineCycleNext<CR>", "Next Buffer" },
  k = { "<cmd>bd<CR>", "Delete Buffer" },
  o = { "<cmd>Telescope find_files<CR>", "Open File" },
  d = {
    name = "Diagnostic",
    d = { "Show Line Diagnostic By Vim API" },
    w = { "Show Cursor Diagnostic" },
    l = { "Show Line Diagnostic" },
    n = { "Show Next Diagnostic" },
    p = { "Show Prev Diagnostic" },
  },
  e = { "<cmd>Telescope buffers<CR>", "Show Buffers" },
  ["="] = format,
}

wk.register(mapping, { prefix = "<leader>" })
wk.register(localMapping, { prefix = "<localleader>" })

wk.setup {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    -- border = "rounded",
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  triggers = { "<leader>", "<localleader>" }, -- automatically setup triggers
}
