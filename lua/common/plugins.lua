require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use {
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
    }
    use "sainnhe/everforest"

    use "folke/which-key.nvim"

    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
    }

    use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }
    use "akinsho/toggleterm.nvim"

    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    -- use {
    --   "tzachar/cmp-tabnine",
    --   run = "./install.sh",
    --   requires = "hrsh7th/nvim-cmp",
    -- }
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"
    use "rafamadriz/friendly-snippets"
    use "onsails/lspkind-nvim"

    use "simrat39/rust-tools.nvim"

    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    use "numToStr/Comment.nvim"

    use "windwp/nvim-autopairs"
    use "tpope/vim-surround"
    use "lukas-reineke/indent-blankline.nvim"
    use "lewis6991/gitsigns.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "arkav/lualine-lsp-progress"
    -- use 'mhartington/formatter.nvim'
    use "nkrkv/nvim-treesitter-rescript"

    use "matze/vim-move"
    use {
      "glepnir/dashboard-nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
    }
    use "ahmedkhalf/project.nvim"
    use "folke/neodev.nvim"
    use {
      "glepnir/lspsaga.nvim",
      branch = "version_2.2",
    }

    use "jose-elias-alvarez/null-ls.nvim"

    use "mfussenegger/nvim-dap"
    use "theHamsta/nvim-dap-virtual-text"
    use "rcarriga/nvim-dap-ui"
    use "puremourning/vimspector"
    use "p00f/clangd_extensions.nvim"
    use "b0o/SchemaStore.nvim"
    use "lewis6991/impatient.nvim"
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
