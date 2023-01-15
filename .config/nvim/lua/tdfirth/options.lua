local cmd = vim.cmd
local opt = vim.opt

cmd("filetype plugin on")
cmd('let &titleold="' .. TERMINAL .. '"')
cmd("set inccommand=split")
cmd("set iskeyword+=-")
cmd("set whichwrap+=<,>,[,],h,l")
cmd("set noshowcmd")

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_localcopydircmd = "cp -r"

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	colorcolumn = "99999",
	completeopt = { "menu", "menuone", "noselect" },
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	hidden = true, -- required to keep multiple buffers and open multiple buffers
	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	scrolloff = 999, -- minimal number of screen lines to keep above and below the cursor
	showmode = false, -- Show mode, e.g. INSERT
	showtabline = 1, -- always show tabs
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
	title = true, -- set the title of window to the value of the titlestring
	-- titlestring = "%<%F%=%l/%L - nvim", -- what the title of the window will be set to
	undodir = CACHE_PATH .. "/undo", -- set an undo directory
	undofile = true, -- enable persisten undo
	updatetime = 300, -- faster completion
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = false, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = true, -- display lines as one long line
	spell = false,
	spelllang = "en",
	wildmode = "list:longest",
}

for k, v in pairs(options) do
	opt[k] = v
end
