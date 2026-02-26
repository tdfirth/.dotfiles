return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "gruvbox-material",
			icons_enabled = false,
			section_separators = "",
			component_separators = "|",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				{
					"diff",
					colored = true,
					symbols = { added = "+", modified = "~", removed = "-" },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
				},
			},
			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]" },
				},
			},
			lualine_x = {
				"encoding",
				{
					"fileformat",
					symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
				},
				{
					"filetype",
					colored = false,
					icon_only = false,
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
