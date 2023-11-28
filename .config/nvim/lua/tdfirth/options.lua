local cmd = vim.cmd
local opt = vim.opt

cmd.colorscheme("zenwritten")

cmd("filetype plugin on")
cmd("set inccommand=split")
cmd("set iskeyword+=-")
cmd("set whichwrap+=<,>,[,],h,l")
cmd("set noshowcmd")
cmd("set titlestring=%t")

local options = {
  backup = false,              -- creates a backup file
  swapfile = false,            -- creates a swapfile

  clipboard = "unnamedplus",   -- allows neovim to access the system clipboard
  cmdheight = 1,               -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,            -- so that `` is visible in markdown files
  fileencoding = "utf-8",      -- the encoding written to a file
  hidden = true,               -- required to keep multiple buffers and open multiple buffers
  hlsearch = true,             -- highlight all matches on previous search pattern
  incsearch = true,            -- show matches incrementally
  ignorecase = true,           -- ignore case in search patterns
  smartcase = true,            -- smart case
  mouse = "a",                 -- allow the mouse to be used in neovim
  pumheight = 10,              -- pop up menu height
  scrolloff = 999,             -- minimal number of screen lines to keep above and below the cursor
  showmode = false,            -- Show mode, e.g. INSERT
  showtabline = 1,             -- always show tabs
  smartindent = true,          -- make indenting smarter again
  splitbelow = true,           -- force all horizontal splits to go below current window
  splitright = true,           -- force all vertical splits to go to the right of current window
  termguicolors = true,        -- set term gui colors (most terminals support this)
  timeoutlen = 500,            -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true,                -- set the title of window to the value of the titlestring
  undofile = true,             -- enable persisten undo
  updatetime = 50,             -- faster completion
  writebackup = false,         -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

  shiftwidth = 4,              -- the number of spaces inserted for each indentation
  tabstop = 4,                 -- insert 2 spaces for a tab
  softtabstop = 4,             -- insert 2 spaces for a tab
  expandtab = true,            -- convert tabs to spaces

  cursorline = true,           -- highlight the current line
  number = true,               -- set numbered lines
  relativenumber = true,       -- set relative numbered lines
  numberwidth = 4,             -- set number column width to 2 {default 4}
  signcolumn = "yes",          -- always show the sign column, otherwise it would shift the text each time

  wrap = true,                 -- display lines as one long line
  spell = false,
  spelllang = "en",
  wildmode = "list:longest",
  laststatus = 3,   -- One statusline for all splits

  shortmess = "ao"
}

for k, v in pairs(options) do opt[k] = v end
