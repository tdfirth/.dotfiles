return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		lazy = true,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		init = function()
			vim.cmd.colorscheme("zenwritten")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		priority = 900,
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					section_separators = "",
					component_separators = "",
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					keymap = {
						accept = "<C-h>",
						next = "<C-j>",
						prev = "<C-k>",
						dismiss = "<C-l>",
					},
				},
			})
		end,
	},
}
