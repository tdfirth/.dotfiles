local function toggle_background(bg)
	vim.cmd("silent !kitten themes --reload-in=all github_" .. bg)
	vim.cmd("colorscheme github_dark")
	vim.cmd("silent set background=" .. bg)
end

vim.api.nvim_create_user_command("Dark", function()
	toggle_background("dark")
end, {})

vim.api.nvim_create_user_command("Light", function()
	toggle_background("light")
end, {})
