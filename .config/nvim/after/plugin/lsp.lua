local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommended")

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "pyright" },
  handlers = {
    lsp_zero.default_setup,
  },
})

local cmp = require("cmp")

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "path" },
    { name = "buffer" },
  }),
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ["<C-n>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
})

lsp_zero.set_sign_icons({
  error = "E",
  warn = "W",
  hint = "H",
  info = "I",
})

vim.diagnostic.config({
  virtual_text = false,
})

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = true, silent = true }

  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, opts)
end)

lsp_zero.setup()

-- TS
require("lspconfig").tsserver.setup({
  single_file_support = false,
  on_init = function(client)
    -- disable formatting capabilities
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
  end,
})
