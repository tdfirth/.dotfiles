local map = vim.keymap.set

-- Ctrl-C to escape (triggers InsertLeave unlike default C-c)
map("i", "<C-c>", "<ESC>", { silent = true })

-- Move through wrapped lines
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("v", "j", "gj", { silent = true })
map("v", "k", "gk", { silent = true })

-- Window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines with Alt-j/k
map("n", "<A-k>", ":m .-2<CR>==", { silent = true })
map("n", "<A-j>", ":m .+1<CR>==", { silent = true })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })

-- Search
map("n", "*", "*N")
map("n", "#", "#N")
map("n", "<C-CR>", ":noh<CR>", { silent = true })

-- Paste without overwriting register in visual
vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')
