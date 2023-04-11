return require("packer").startup(function()
  use "wbthomason/packer.nvim"

  use {
    "ellisonleao/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
  }

  use "folke/which-key.nvim"
  use "sainnhe/everforest"
  use "rakr/vim-one"

  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
  }

  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use "akinsho/toggleterm.nvim"

  use { "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" }

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  -- vsnip
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "rafamadriz/friendly-snippets"
  -- lspkind
  use "onsails/lspkind-nvim"

  use "simrat39/rust-tools.nvim"

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }

  use "windwp/nvim-autopairs"
  use "tpope/vim-surround"
  use {
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  }
  use "lukas-reineke/indent-blankline.nvim"
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use "norcalli/nvim-colorizer.lua"
  use "arkav/lualine-lsp-progress"
  use "mhartington/formatter.nvim"
  use "rescript-lang/vim-rescript"
end)
