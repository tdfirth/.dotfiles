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
  use 'tpope/vim-dispatch'
  use 'tpope/vim-eunuch'
  use { "neovim/nvim-lspconfig" }
  use { "kabouzeid/nvim-lspinstall", event = "VimEnter" }
  -- Telescope
  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }
  use {
    "tdfirth/telescope.nvim",
    config = [[require('lv-telescope')]],
  }
  use "nvim-telescope/telescope-fzy-native.nvim"
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("lv-compe").config()
    end,
  }
  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Neoformat
  use {
    "sbdchd/neoformat",
    config = function()
      require "lv-neoformat"
    end,
    event = "BufRead",
  }

  use {
    "kyazdani42/nvim-tree.lua",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("lv-nvimtree").config()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("lv-gitsigns").config()
    end,
    event = "BufRead",
  }

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require "lv-which-key"
    end,
    event = "BufWinEnter",
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim" },
    config = function()
      require "lv-autopairs"
    end,
  }

  use "tpope/vim-commentary"

  -- Color
  use { "christianchiarulli/nvcode-color-schemes.vim", opt = true }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status Line and Bufferline
  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require "lv-galaxyline"
    end,
  }

  -- LANGUAGE SPECIFIC GOES HERE
  use {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require "lv-vimtex"
    end,
  }

  use "fatih/vim-go"
  use {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  }
  use "Julian/lean.nvim"

  -- Javascript / Typescript
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  }

  -- Pretty parentheses
  use {
    "p00f/nvim-ts-rainbow",
    disable = not O.plugin.ts_rainbow.active,
  }

  -- Autotags <div>|</div>
  use {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    disable = not O.plugin.ts_autotag.active,
  }

  -- Custom semantic text objects
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    disable = not O.plugin.ts_textobjects.active,
  }

  -- Smart text objects
  use {
    "RRethy/nvim-treesitter-textsubjects",
    disable = not O.plugin.ts_textsubjects.active,
  }

  -- Text objects using hint labels
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    event = "BufRead",
    disable = not O.plugin.ts_hintobjects.active,
  }

  for _, plugin in pairs(O.user_plugins) do
    packer.use(plugin)
  end
end)
