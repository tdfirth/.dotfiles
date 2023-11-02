vim.cmd([[
augroup autofmt
  autocmd!
  autocmd BufWritePre * try | undojoin | silent Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END
]])

vim.g.neoformat_run_all_formatters = 0

vim.g.neoformat_enabled_python = { "black" }
vim.g.neoformat_enabled_javascript = { "prettier" }
