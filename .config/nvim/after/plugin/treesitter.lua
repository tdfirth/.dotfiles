local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "go",
    "rust",
    "toml",
    "query",
    "html",
    "typescript",
    "tsx",
    "javascript",
    "lua",
    "json",
    "css",
    "yaml",
    "python",
    "zig",
  },

  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  autopairs = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>s", -- maps in normal mode to init the node/scope selection
      node_incremental = "<leader>s", -- increment to the upper named parent
      node_decremental = "<M-C-s>", -- decrement to the previous node
      scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
    },
  },

  indent = { enable = true },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
