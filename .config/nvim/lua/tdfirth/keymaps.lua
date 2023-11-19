local keymaps = {
  i = {
    ctrl = {},
    shift = {},
    alt = {},
    leader = {},
    g = {},
    _ = {},
  },
  n = {
    ctrl = {},
    shift = {},
    alt = {},
    leader = {},
    g = {},
    _ = {},
  },
  v = {
    ctrl = {},
    leader = {},
    g = {},
    _ = {},
  },
  t = {
    ctrl = {},
    leader = {},
    g = {},
    _ = {},
  },
  x = {
    ctrl = {},
    shift = {},
    alt = {},
    leader = {},
    g = {},
    _ = {},
  },
}

-- Set the leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","
keymaps.n._["<Space>"] = { "<NOP>" }

-- Ctrl-C to escape
keymaps.n.ctrl["c"] = { "<ESC>", { silent = true } }
keymaps.i.ctrl["c"] = { "<ESC>", { silent = true } }
keymaps.x.ctrl["c"] = { "<ESC>", { silent = true } }
keymaps.v.ctrl["c"] = { "<ESC>", { silent = true } }
keymaps.t.ctrl["c"] = { "<ESC>", { silent = true } }

-- Better window movement
keymaps.n.ctrl["h"] = { "<C-w>h", { silent = true } }
keymaps.n.ctrl["j"] = { "<C-w>j", { silent = true } }
keymaps.n.ctrl["k"] = { "<C-w>k", { silent = true } }
keymaps.n.ctrl["l"] = { "<C-w>l", { silent = true } }

-- Move nicely through wrapped lines
keymaps.n._["j"] = { "gj" }
keymaps.n._["k"] = { "gk" }
keymaps.v._["j"] = { "gj" }
keymaps.v._["k"] = { "gk" }

-- Terminal window navigation
keymaps.t.ctrl["h"] = { "<C-\\><C-N><C-w>h" }
keymaps.t.ctrl["j"] = { "<C-\\><C-N><C-w>j" }
keymaps.t.ctrl["k"] = { "<C-\\><C-N><C-w>k" }
keymaps.t.ctrl["l"] = { "<C-\\><C-N><C-w>l" }
keymaps.i.ctrl["h"] = { "<C-\\><C-N><C-w>h" }
keymaps.i.ctrl["j"] = { "<C-\\><C-N><C-w>j" }
keymaps.i.ctrl["k"] = { "<C-\\><C-N><C-w>k" }
keymaps.i.ctrl["l"] = { "<C-\\><C-N><C-w>l" }
keymaps.t._["<Esc>"] = { "<C-\\><C-n>" }

-- Better indenting
keymaps.v._["<"] = { "<gv" }
keymaps.v._[">"] = { ">gv" }

-- Move current line / block with Alt-j/k ala vscode.
keymaps.n.alt["j"] = { ":m .+1<CR>==" }
keymaps.n.alt["k"] = { ":m .-2<CR>==" }
keymaps.i.alt["j"] = { "<Esc>:m .+1<CR>==gi" }
keymaps.i.alt["k"] = { "<Esc>:m .-2<CR>==gi" }

-- QuickFix
keymaps.n._["]q"] = { ":cnext<CR>" }
keymaps.n._["[q"] = { ":cprev<CR>" }

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')

-- Close a buffer without closing the window
keymaps.n.leader["d"] = { ":bp<bar>sp<bar>bn<bar>bd<CR>" }

-- Test
keymaps.n.leader["tf"] = { ":TestFile<CR>" }
keymaps.n.leader["tl"] = { ":TestLast<CR>" }
keymaps.n.leader["tn"] = { ":TestNearest<CR>" }

-- Netrw
keymaps.n.ctrl["p"] = { ":Vexplore<CR>" }

-- Search
keymaps.n._["<CR>"] = { ":noh<CR>" }
keymaps.n.ctrl["/"] = { ":Telescope live_grep<CR>" }
keymaps.n.leader["ff"] = { ":Telescope find_files<CR>" }
keymaps.n.leader["fs"] = { ":Telescope grep_string<CR>" }
keymaps.n.ctrl["b"] = { ":Telescope buffers<CR>" }
keymaps.n._["gd"] = { ":Telescope lsp_definitions<CR>" }
keymaps.n._["gr"] = { ":Telescope lsp_references<CR>" }
keymaps.n.leader["ld"] = { ":Telescope diagnostics<CR>" }
keymaps.n.leader["ls"] = { ":Telescope lsp_workspace_symbols<CR>" }

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
