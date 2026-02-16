return {
	"sainnhe/gruvbox-material",
	config = function()
		vim.o.background = "dark"
		vim.g.gruvbox_material_background = "soft"
		vim.cmd("colorscheme gruvbox-material")

		vim.api.nvim_set_hl(0, "Search", { bg = "#4f4946", fg = "#d4be98" })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5a524c", fg = "#d4be98" })
		vim.api.nvim_set_hl(0, "CurSearch", { bg = "#5a524c", fg = "#d4be98" })
		vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#4f4946", fg = "#d4be98" })
		vim.api.nvim_set_hl(0, "MatchParen", { bg = "#4f4946", fg = "#d4be98", bold = true })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#4f4946" })
	end,
}
