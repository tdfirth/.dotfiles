local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = ","

opt.iskeyword:append("-")
opt.whichwrap:append("<,>,[,],h,l")
opt.showcmd = false
opt.titlestring = "%t"

opt.inccommand = "split"
opt.backup = false
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.pumheight = 10
opt.scrolloff = 999
opt.showmode = false
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.title = true
opt.undofile = true
opt.updatetime = 50
opt.timeoutlen = 350
opt.writebackup = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.wrap = true
opt.spelllang = "en"
opt.wildmode = "list:longest"
opt.laststatus = 3
opt.shortmess = "ao"
opt.ignorecase = true
opt.smartcase = true
