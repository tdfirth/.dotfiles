local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  -- LSP
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      -- { "L3MON4D3/LuaSnip" },
      -- { "saadparwaiz1/cmp_luasnip" },

      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
  })

  -- Misc
  use("tpope/vim-commentary")
  use("tpope/vim-dispatch")
  use("tpope/vim-eunuch")
  use("tpope/vim-projectionist")
  use("tpope/vim-surround")
  use("vim-test/vim-test")
  use("mbbill/undotree")
  use("sbdchd/neoformat")
  use("windwp/nvim-autopairs")

  -- Theme
  use({
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim",
  })

  -- Copilot
  use({
    "github/copilot.vim",
    -- config = function()
    --   vim.g.copilot_no_maps = true
    --   vim.g.copilot_no_tab_map = true
    --   vim.g.copilot_assume_mapped = true
    --   vim.g.copilot_filetypes = { ["*"] = false }
    -- end,
  })

  -- Zig
  use("ziglang/zig.vim")

  -- Clojure
  use("eraserhd/parinfer-rust")
  use("Olical/conjure")
end)
