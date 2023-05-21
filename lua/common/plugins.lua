require("lazy").setup {
  "folke/which-key.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
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
  { "jose-elias-alvarez/null-ls.nvim", event = "BufReadPre" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nkrkv/nvim-treesitter-rescript",
    },
    build = ":TSUpdate",
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
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
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
  },
  { "simrat39/rust-tools.nvim", event = "BufReadPre" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs",
  "tpope/vim-surround",
  "lukas-reineke/indent-blankline.nvim",
  "lewis6991/gitsigns.nvim",
  "NvChad/nvim-colorizer.lua",
  "matze/vim-move",
  -- 'mhartington/formatter.nvim'
  {
    "glepnir/dashboard-nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
  },
  {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    config = function()
      require("hlsearch").setup()
    end,
  },
  -- theme start
  { "catppuccin/nvim", name = "catppuccin" },
  { "limitLiu/everforest-nvim", lazy = false, priority = 1000 },
  "limitLiu/zephyr-nvim",
  "RRethy/vim-illuminate",
  -- theme end
}
