local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    winblend = 0,
    path_display = {
      truncate = 3
    },
    results_title = false,
    prompt_title = false,
    dynamic_preview_title = true,
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.5
    },
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    },

    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = true,

    file_ignore_patterns = {
      ".git/.*", "node_modules/.*", "target/.*", "deps/.*", "_build/.*",
      "zig%-out/.*", "zig%-cache/.*", "*.svg"
    },

    mappings = {
      i = {
        ["<C-a>"] = actions.select_all,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-j>"] = require("telescope.actions").cycle_history_next,
        ["<C-k>"] = require("telescope.actions").cycle_history_prev
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-a>"] = actions.select_all,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default + actions.center
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                         -- false will only do exact matching
      override_generic_sorter = true,       -- override the generic sorter
      override_file_sorter = true,          -- override the file sorter
      case_mode = "smart_case"              -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      hijack_netrw = true,
      dir_icon = "",
      git_status = false,
      mappings = {
        ["i"] = {
          ["<CR>"] = actions.select_default
        },
        ["n"] = {
          ["<CR>"] = actions.select_default
        }
      }
    }
  }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
