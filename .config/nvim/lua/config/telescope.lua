local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    winblend = 0,
    layout_strategy = "horizontal",
    show_line = false;
    prompt_title = false;
    results_title = false;
    preview_title = false;
    layout_config = {
      width = 0.90,
      height = 0.85,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = true,

    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},

    file_ignore_patterns = {
      ".git/.*",
      "node_modules/.*",
      "target/.*",
    },

    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-a>"] = actions.select_all,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzf")

