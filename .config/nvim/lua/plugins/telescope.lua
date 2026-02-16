return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
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
				path_display = { truncate = 3 },
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
				sorting_strategy = "ascending",
				scroll_strategy = "cycle",
				file_ignore_patterns = {
					".git/.*",
					"node_modules/.*",
					"target/.*",
                    "data/.*",
				},
				mappings = {
					i = {
						["<M-q>"] = actions.select_all + actions.smart_send_to_qflist + actions.open_qflist,
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
					},
					n = {
						["<M-q>"] = actions.select_all + actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		require("telescope").load_extension("fzf")

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
	end,
}
