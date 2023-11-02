local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  use "airblade/vim-rooter"
  use "tpope/vim-dispatch"
  use "tpope/vim-eunuch"
  use "tpope/vim-commentary"

  -- Theme
  use "kyazdani42/nvim-web-devicons"
  use "sainnhe/everforest"
  use "andreypopp/vim-colors-plain"

  -- use "neovim/nvim-lspconfig"
  -- use "kabouzeid/nvim-lspinstall"
  -- Telescope
  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }
  use {
    "tdfirth/telescope.nvim",
    config = [[require("config.telescope")]],
  }
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  -- Autocomplete
  -- use {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   config = function()
  --     require("config.cmp").config()
  --   end,
  -- }
  -- use { "hrsh7th/cmp-buffer" }
  -- use { "hrsh7th/cmp-path" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.treesitter").config()
		end,
  }

  -- Neoformat
  use {
    "sbdchd/neoformat",
    config = function()
      require "config.neoformat"
    end,
    event = "BufRead",
  }

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require "config.which-key"
    end,
    event = "BufWinEnter",
  }

  -- LANGUAGE SPECIFIC GOES HERE
  use {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require "config.vimtex"
    end,
  }

  use "fatih/vim-go"
  use {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  }

  use {
    "elixir-editors/vim-elixir"
  }

  for _, plugin in pairs(O.user_plugins) do
    packer.use(plugin)
  end
end)
