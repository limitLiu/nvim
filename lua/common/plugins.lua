require("lazy").setup {
  "folke/which-key.nvim",
  -- "jose-elias-alvarez/nvim-lsp-ts-utils",
  "ahmedkhalf/project.nvim",
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",
  "puremourning/vimspector",
  { "p00f/clangd_extensions.nvim", lazy = true },
  "b0o/SchemaStore.nvim",
  { "williamboman/mason.nvim", lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  "folke/neodev.nvim",
  "neovim/nvim-lspconfig",
  "limitLiu/nvim-treesitter-rescript",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "kyazdani42/nvim-tree.lua",
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      -- "rafamadriz/friendly-snippets",
    },
  },
  "onsails/lspkind-nvim",
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    event = "BufReadPre",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs",
  "tpope/vim-surround",
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  "lewis6991/gitsigns.nvim",
  "NvChad/nvim-colorizer.lua",
  "matze/vim-move",
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "glepnir/dashboard-nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    config = function()
      require("hlsearch").setup()
    end,
  },
  "stevearc/dressing.nvim",
  "folke/trouble.nvim",
  { "glepnir/oceanic-material", priority = 1000 },
  { "glepnir/nerdicons.nvim", cmd = "NerdIcons" },
  -- theme start
  { "catppuccin/nvim", name = "catppuccin" },
  { "limitLiu/everforest-nvim", lazy = false, priority = 1000 },
  "limitLiu/zephyr-nvim",
  "RRethy/vim-illuminate",
  -- theme end
}
