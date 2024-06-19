return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"vim",
			"vimdoc",
			"go",
			"rust",
			"toml",
			"query",
			"typescript",
			"tsx",
			"javascript",
			"json",
			"css",
			"yaml",
			"python",
			"zig",
		},
		auto_install = true,
		autopairs = {
			enable = true,
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>s", -- maps in normal mode to init the node/scope selection
				node_incremental = "<leader>s", -- increment to the upper named parent
				node_decremental = "<M-C-s>", -- decrement to the previous node
				scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
			},
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup(opts)
	end,
}
