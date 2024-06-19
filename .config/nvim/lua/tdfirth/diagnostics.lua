vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
})

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float()
end, { silent = true })
