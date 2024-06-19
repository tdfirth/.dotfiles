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
		"nvim-telescope/telescope-file-browser.nvim",
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
					height = 0.6,
				},
				border = true,
				borderchars = {
					prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
					results = { " " },
					preview = { " " },
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
				file_browser = {
					hijack_netrw = true,
					dir_icon = "",
					grouped = true,
					mappings = {
						["i"] = {
							["<CR>"] = actions.select_default,
						},
						["n"] = {
							["<CR>"] = actions.select_default,
						},
					},
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("file_browser")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		map("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		map("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		map("n", "<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope" })
		map("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		map("n", "<leader>fd", function()
			builtin.diagnostics({ path_display = "hidden", wrap_results = true })
		end, { desc = "[F]ind [D]iagnostics" })
		map("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
		map("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
		map("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "[F]ind in [B]uffer" })
		map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		map("n", "<C-/>", builtin.live_grep, { desc = "[L]ive [G]rep" })
		map("n", "<C-p>", function()
			require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true })
		end, { desc = "Browse Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
	end,
}
