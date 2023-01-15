-- Load the utils first as it has a load of helper functions
-- that are used everywhere else.
require("tdfirth.utils")

-- Load the colorscheme
vim.cmd.colorscheme("tdfirth")

require("tdfirth.options")
require("tdfirth.statusline")
require("tdfirth.keymaps")
require("tdfirth.plugins")
require("tdfirth.cmp")
require("tdfirth.lsp")
require("tdfirth.telescope")
require("tdfirth.treesitter")
require("tdfirth.autopairs")
