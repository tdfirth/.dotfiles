local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "go", "rust", "toml", "query", "html", "typescript", "tsx", "yaml", "vim",
      "lua", "json"
    },

    highlight = {
      enable = true,
      use_languagetree = false,
      disable = {},
      custom_captures = custom_captures
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>s", -- maps in normal mode to init the node/scope selection
        node_incremental = "<leader>s", -- increment to the upper named parent
        node_decremental = "<M-C-s>", -- decrement to the previous node
        scope_incremental = "<M-e>" -- increment to the upper scope (as defined in locals.scm)
      }
    },

    indent = {
      enable = false
    }
  }
end

return M
