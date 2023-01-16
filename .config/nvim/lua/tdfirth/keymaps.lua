local keymap = vim.api.nvim_set_keymap

local function leader(seq)
	return "<leader>" .. seq
end

local keymaps = {
	i = {
		ctrl = {},
		shift = {},
		alt = {},
		leader = {},
		g = {},
		lit = {},
	},
	n = {
		ctrl = {},
		shift = {},
		alt = {},
		leader = {},
		g = {},
		lit = {},
	},
	v = {
		ctrl = {},
		leader = {},
		g = {},
		lit = {},
	},
	t = {
		ctrl = {},
		leader = {},
		g = {},
		lit = {},
	},
}

-- Set the leader
vim.g.mapleader = " "
keymaps.n.lit["<Space>"] = { "<NOP>" }

-- Ctrl-C to escape
keymaps.n.ctrl["c"] = { "<ESC>", { silent = true } }
keymaps.i.ctrl["c"] = { "<ESC>", { silent = true } }

-- Better window movement
keymaps.n.ctrl["h"] = { "<C-w>h", { silent = true } }
keymaps.n.ctrl["j"] = { "<C-w>j", { silent = true } }
keymaps.n.ctrl["k"] = { "<C-w>k", { silent = true } }
keymaps.n.ctrl["l"] = { "<C-w>l", { silent = true } }

-- Move nicely through wrapped lines
keymaps.n.lit["j"] = { "gj" }
keymaps.n.lit["k"] = { "gk" }
keymaps.v.lit["j"] = { "gj" }
keymaps.v.lit["k"] = { "gk" }

-- Terminal window navigation
keymaps.t.ctrl["h"] = { "<C-\\><C-N><C-w>h" }
keymaps.t.ctrl["j"] = { "<C-\\><C-N><C-w>j" }
keymaps.t.ctrl["k"] = { "<C-\\><C-N><C-w>k" }
keymaps.t.ctrl["l"] = { "<C-\\><C-N><C-w>l" }
keymaps.i.ctrl["h"] = { "<C-\\><C-N><C-w>h" }
keymaps.i.ctrl["j"] = { "<C-\\><C-N><C-w>j" }
keymaps.i.ctrl["k"] = { "<C-\\><C-N><C-w>k" }
keymaps.i.ctrl["l"] = { "<C-\\><C-N><C-w>l" }
keymaps.t.lit["<Esc>"] = { "<C-\\><C-n>" }

-- Better indenting
keymaps.v.lit["<"] = { "<gv" }
keymaps.v.lit[">"] = { ">gv" }

-- Tab switch buffer
keymaps.n.shift["TAB"] = { ":bprevious<CR>" }
keymaps.n.lit["<TAB>"] = { ":bnext<CR>" }

-- Move current line / block with Alt-j/k ala vscode.
keymaps.n.alt["j"] = { ":m .+1<CR>==" }
keymaps.n.alt["k"] = { ":m .-2<CR>==" }
keymaps.i.alt["j"] = { "<Esc>:m .+1<CR>==gi" }
keymaps.i.alt["k"] = { "<Esc>:m .-2<CR>==gi" }

-- QuickFix
keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')

-- Close a buffer without closing the window
keymap("n", leader("d"), ":bp<bar>sp<bar>bn<bar>bd<CR>", { noremap = true, silent = true })

-- Search
keymap("n", leader("f"), ":Telescope find_files<CR>", { noremap = true, silent = true })
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

keymaps.v.ctrl["Space"] = {
	function()
		print("Grepping")
		require("telescope.builtin").grep_string({ search = vim.get_visual_selection() })
	end,
	{ noremap = true, silent = true },
}

vim.api.nvim_create_user_command("ReloadConfig", function()
	print("Reloading vim config...")
	vim.cmd("source $MYVIMRC")
	print("Done.")
end, {})

local function make_binding(modifier, binding)
	if modifier == "ctrl" then
		return "<C-" .. binding .. ">"
	elseif modifier == "shift" then
		return "<S-" .. binding .. ">"
	elseif modifier == "alt" then
		return "<A-" .. binding .. ">"
	elseif modifier == "leader" then
		return "<leader>" .. binding
	elseif modifier == "g" then
		return "g" .. binding
	else
		return binding
	end
end

for mode, mappings in pairs(keymaps) do
	for modifier, bindings in pairs(mappings) do
		for binding, def in pairs(bindings) do
			local action = def[1]
			local opts = def[2]
			if opts == nil then
				opts = { silent = true, noremap = true }
			end
			vim.keymap.set(mode, make_binding(modifier, binding), action, opts)
		end
	end
end
