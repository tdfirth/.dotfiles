local opt = vim.opt

opt.autoindent = true
opt.cindent = true
opt.expandtab = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

vim.bo.commentstring = "// %s"

local function copy_break_for_lldb()
	local path = vim.api.nvim_buf_get_name(0)
	local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local bp = "b " .. path .. ":" .. line
	vim.fn.setreg("+", bp)
end

vim.keymap.set("n", "<leader>lb", copy_break_for_lldb, {
	silent = true,
	noremap = true,
})
