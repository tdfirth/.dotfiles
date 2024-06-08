return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				winblend = 0,
				path_display = {
					truncate = 3,
				},
				results_title = false,
				prompt_title = false,
				dynamic_preview_title = true,
				layout_strategy = "bottom_pane",
				layout_config = {
					height = 0.5,
				},
				border = true,
				borderchars = {
					prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
					results = { " " },
					preview = { " " },
					-- preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},

				selection_strategy = "reset",
				sorting_strategy = "ascending",
				scroll_strategy = "cycle",
				color_devicons = true,

				file_ignore_patterns = {
					".git/.*",
					"node_modules/.*",
					"target/.*",
					"deps/.*",
					"_build/.*",
					"zig%-out/.*",
					"zig%-cache/.*",
					"*.svg",
					"assets/.*",
				},

				mappings = {
					i = {
						["<C-a>"] = actions.select_all,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<CR>"] = actions.select_default + actions.center,
						["<C-j>"] = require("telescope.actions").cycle_history_next,
						["<C-k>"] = require("telescope.actions").cycle_history_prev,
					},
					n = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-a>"] = actions.select_all,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<CR>"] = actions.select_default + actions.center,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		map("n", "<C-/>", builtin.live_grep, { desc = "[L]ive [G]rep" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
