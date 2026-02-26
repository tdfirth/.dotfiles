return {
	"lewis6982/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "" },
			change = { text = "" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "" },
			untracked = { text = "" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local map = vim.keymap.set

			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, { buffer = bufnr })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, { buffer = bufnr })

			map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
			map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { buffer = bufnr, desc = "Stage selected lines" })
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { buffer = bufnr, desc = "Reset selected lines" })
			map("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
			map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
		end,
	},
}
