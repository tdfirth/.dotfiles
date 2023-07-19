-- Global utils.
_G.CONFIG_PATH = vim.fn.stdpath("config")
_G.DATA_PATH = vim.fn.stdpath("data")
_G.CACHE_PATH = vim.fn.stdpath("cache")
_G.TERMINAL = vim.fn.expand("$TERMINAL")
_G.utils = {}

--- Set vim options with a nested table like API with the format vim.<first_key>.<second_key>.<value>
-- @param options the nested table of vim options
function utils.vim_opts(options)
	for scope, table in pairs(options) do
		for setting, value in pairs(table) do
			vim[scope][setting] = value
		end
	end
end

function utils.check_lsp_client_active(name)
	local clients = vim.lsp.get_active_clients()
	for _, client in pairs(clients) do
		if client.name == name then
			return true
		end
	end
	return false
end

function utils.define_augroups(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

utils.define_augroups({
	_general_settings = {
		{
			"TextYankPost",
			"*",
			"lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
		},
		{
			"BufWinEnter",
			"*",
			"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
		},
		{
			"BufRead",
			"*",
			"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
		},
		{
			"BufNewFile",
			"*",
			"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
		},
	},
	_markdown = {
		{ "FileType", "markdown", "setlocal wrap" },
		{ "FileType", "markdown", "setlocal spell" },
	},
	_buffer_bindings = {
		{ "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
	},
	_auto_resize = {
		-- will cause split windows to be resized evenly if main window is resized
		{ "VimResized", "*", "wincmd =" },
	},
	_packer_compile = {
		-- will cause split windows to be resized evenly if main window is resized
		{ "BufWritePost", "plugins.lua", "PackerCompile" },
	},
})

return utils
