return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})

			vim.cmd("colorscheme github_dark")
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			fallback = "light",
		},
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
