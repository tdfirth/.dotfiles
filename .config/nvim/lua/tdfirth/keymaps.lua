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

-- Move lines
map("n", "<M-Down>", ":m .+1<CR>==", { silent = true })
map("n", "<M-Up>", ":m .-2<CR>==", { silent = true })
map("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", { silent = true })
map("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", { silent = true })

-- Diagnostic float
map("n", "<M-k>", vim.diagnostic.open_float, { silent = true })

-- Search
map("n", "*", "*N")
map("n", "#", "#N")
map("n", "<C-CR>", ":noh<CR>", { silent = true })
