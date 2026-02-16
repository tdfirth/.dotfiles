return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
		},
		cmdline = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
			},
		},
		completion = {
			list = { selection = { preselect = true, auto_insert = false } },
		},
		sources = {
			default = { "lsp", "buffer", "path" },
		},
	},
}
