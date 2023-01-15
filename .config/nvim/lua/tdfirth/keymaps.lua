local keymap = vim.api.nvim_set_keymap

-- Set leader
keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Ctrl-C to escape
keymap("i", "<C-c>", "<ESC>", { silent = true })
keymap("n", "<C-c>", "<ESC>", { silent = true })

-- better window movement
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Move nicely through wrapped lines
keymap("n", "j", "gj", { silent = true, noremap = true })
keymap("n", "k", "gk", { silent = true, noremap = true })
keymap("v", "j", "gj", { silent = true, noremap = true })
keymap("v", "k", "gk", { silent = true, noremap = true })

-- Terminal window navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
keymap("i", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
keymap("i", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
keymap("i", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
keymap("i", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

if vim.fn.has("mac") == 1 then
	keymap("n", "<A-Up>", ":resize -2<CR>", { silent = true })
	keymap("n", "<A-Down>", ":resize +2<CR>", { silent = true })
	keymap("n", "<A-Left>", ":vertical resize -2<CR>", { silent = true })
	keymap("n", "<A-Right>", ":vertical resize +2<CR>", { silent = true })
else
	keymap("n", "<C-Up>", ":resize -2<CR>", { silent = true })
	keymap("n", "<C-Down>", ":resize +2<CR>", { silent = true })
	keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
	keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })
end

-- better indenting
keymap("v", "<", "<gv", { noremap = true, silent = true })
keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Tab switch buffer
keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move current line / block with Alt-j/k ala vscode.
keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- QuickFix
keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')

-- Close a buffer without closing the window
keymap("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>", { noremap = true, silent = true })

-- Search
keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
keymap("n", "<C-b>", ":Telescope buffers<CR>", { noremap = true, silent = true })
keymap("n", "<C-/>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
keymap(
	"n",
	"<C-Space>",
	':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>',
	{ noremap = true, silent = true }
)

function vim.get_visual_selection()
	local _, line_start, col_start, _ = unpack(vim.fn.getpos("'<"))
	local _, line_end, col_end, _ = unpack(vim.fn.getpos("'>"))
	local lines = vim.fn.getline(line_start, line_end)
	if vim.fn.len(lines) == 0 then
		return ""
	end
	lines[1] = string.sub(lines[1], col_start)
	local last = table.getn(lines)
	lines[last] = string.sub(lines[last], 0, col_end)
	return vim.fn.join(lines, "\n")
end

keymap(
	"v",
	"<C-Space>",
	':lua require("telescope.builtin").grep_string { search = vim.get_visual_selection() }<CR>',
	{ noremap = true, silent = true }
)

--keymap("n", "<leader>cr", function()
--	print("Reloading config...")
--	require("tdfirth.utils").reload_config()
--end, { noremap = true, silent = true })

