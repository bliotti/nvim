return {
  -- Lazy.nvim can manage itself
  { "folke/lazy.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Rose Pine colorscheme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup()
      vim.cmd.colorscheme("rose-pine")
    end,
  },

  -- Treesitter and related plugins
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/playground" },

  -- Harpoon
  { "theprimeagen/harpoon" },

  -- UndoTree
  { "mbbill/undotree" },

  -- Fugitive
  { "tpope/vim-fugitive" },

  -- LSP Zero and dependencies
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          width = 90,
          options = {
            number = true,
            relativenumber = true,
          },
        },
      }
    end,
  },

  -- Vim-Be-Good
  { "ThePrimeagen/vim-be-good" },

  -- GitHub Copilot
  { "github/copilot.vim" },
}
