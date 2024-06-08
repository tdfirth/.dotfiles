local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-dispatch",
	"tpope/vim-eunuch",
	"tpope/vim-projectionist",
	"tpope/vim-surround",
	"vim-test/vim-test",
	"mbbill/undotree",
	{
		"stevearc/oil.nvim",
		opts = {},
	},
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
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
	{ import = "plugins" },
})
