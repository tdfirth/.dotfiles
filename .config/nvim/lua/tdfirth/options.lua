local cmd = vim.cmd
local opt = vim.opt

cmd.colorscheme("zenwritten")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

cmd("filetype plugin on")
cmd("set iskeyword+=-")
cmd("set whichwrap+=<,>,[,],h,l")
cmd("set noshowcmd")
cmd("set titlestring=%t")


opt.inccommand = 'split'
opt.backup = false            -- creates a backup file
opt.swapfile = false          -- creates a swapfile
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0          -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"    -- the encoding written to a file
opt.hidden = true             -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = true           -- highlight all matches on previous search pattern
opt.incsearch = true          -- show matches incrementally
opt.ignorecase = true         -- ignore case in search patterns
opt.smartcase = true          -- smart case
opt.mouse = "a"               -- allow the mouse to be used in neovim
opt.pumheight = 10            -- pop up menu height
opt.scrolloff = 999           -- minimal number of screen lines to keep above and below the cursor
opt.showmode = false          -- Show mode, e.g. INSERT
opt.showtabline = 1           -- always show tabs
opt.autoindent = true         -- enable auto-indenting
opt.smartindent = true        -- make indenting smarter again
opt.cindent = true            -- more advanced indenting for C-like languages
opt.splitbelow = true         -- force all horizontal splits to go below current window
opt.splitright = true         -- force all vertical splits to go to the right of current window
opt.termguicolors = true      -- set term gui colors (most terminals support this)
opt.title = true              -- set the title of window to the value of the titlestring
opt.undofile = true           -- enable persisten undo
opt.updatetime = 50           -- faster completion
opt.timeoutlen = 300          -- time to wait for a mapped sequence to complete (in milliseconds)
opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.shiftwidth = 4            -- the number of spaces inserted for each indentation
opt.tabstop = 4               -- insert 2 spaces for a tab
opt.softtabstop = 4           -- insert 2 spaces for a tab
opt.expandtab = true          -- convert tabs to spaces
opt.cursorline = true         -- highlight the current line
opt.number = true             -- set numbered lines
opt.relativenumber = true     -- set relative numbered lines
opt.numberwidth = 4           -- set number column width to 2 {default 4}
opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
opt.wrap = true               -- display lines as one long line
opt.spell = false
opt.spelllang = "en"
opt.wildmode = "list:longest"
opt.laststatus = 3 -- One statusline for all splits
opt.shortmess = "ao"
