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
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.95,
					height = 0.95,
					preview_width = 0.55,
					prompt_position = "top",
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
						["<M-q>"] = actions.select_all + actions.smart_send_to_qflist + actions.open_qflist,
						["<CR>"] = actions.select_default + actions.center,
						["<C-j>"] = require("telescope.actions").cycle_history_next,
						["<C-k>"] = require("telescope.actions").cycle_history_prev,
					},
					n = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<M-q>"] = actions.select_all + actions.smart_send_to_qflist + actions.open_qflist,
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

		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		local function get_visual_selection()
			vim.cmd('noau normal! "vy')
			return vim.fn.getreg("v")
		end

		map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
		map("n", "<C-/>", builtin.live_grep, { desc = "Live grep" })
		map("v", "<C-/>", function()
			builtin.live_grep({ default_text = get_visual_selection() })
		end, { desc = "Grep selection" })
		map("n", "<C-b>", builtin.buffers, { desc = "Buffers" })
		map("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Find in buffer" })
		map("n", "<M-d>", function()
			builtin.diagnostics({ path_display = "hidden", wrap_results = true })
		end, { desc = "Diagnostics" })
		map("n", "<M-r>", builtin.resume, { desc = "Resume last picker" })
		map("n", "<leader>h", builtin.help_tags, { desc = "Help tags" })
	end,
}
