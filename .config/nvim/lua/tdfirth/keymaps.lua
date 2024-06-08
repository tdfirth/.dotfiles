local map = vim.keymap.set
local silent = { silent = true }
local silent_noremap = {
	silent = true,
	noremap = true,
}

-- Ctrl-C to escape
map("n", "<C-c>", "<ESC>", silent)
map("i", "<C-c>", "<ESC>", silent)
map("x", "<C-c>", "<ESC>", silent)
map("v", "<C-c>", "<ESC>", silent)
map("t", "<C-c>", "<ESC>", silent)

-- Move through wrapped lines without g
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("v", "j", "gj", { silent = true })
map("v", "k", "gk", { silent = true })

-- Better window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", silent_noremap)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", silent_noremap)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", silent_noremap)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", silent_noremap)
map("i", "<C-h>", "<C-\\><C-N><C-w>h", silent_noremap)
map("i", "<C-j>", "<C-\\><C-N><C-w>j", silent_noremap)
map("i", "<C-k>", "<C-\\><C-N><C-w>k", silent_noremap)
map("i", "<C-l>", "<C-\\><C-N><C-w>l", silent_noremap)
map("t", "<Esc>", "<C-\\><C-n>", silent_noremap)

-- Better indenting
map("v", "<", "<gv", silent_noremap)
map("v", ">", ">gv", silent_noremap)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-k>", ":m .-2<CR>==", silent_noremap)
map("n", "<A-j>", ":m .+1<CR>==", silent_noremap)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", silent_noremap)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", silent_noremap)

-- Close a buffer without closing the window
map("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>", silent_noremap)

-- Search
map("n", "<C-CR>", ":noh<CR>", silent_noremap)

-- Oil
map("n", "<C-p>", "<CMD>Oil<CR>", silent_noremap)

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')
