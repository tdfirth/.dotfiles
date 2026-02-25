vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

vim.lsp.config('ty', {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml' },
})

vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = args.buf, desc = desc })
    end
    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('gy', vim.lsp.buf.type_definition, 'Go to type definition')
  end,
})

vim.lsp.enable('ty')
vim.lsp.enable('ruff')
