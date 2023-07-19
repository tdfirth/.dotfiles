-- autoformat
require("tdfirth.utils").define_augroups {
  autoformat = {
    {
      "BufWritePre",
      "*",
      [[try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]],
    },
  },
}

vim.g.neoformat_run_all_formatters = 0

vim.g.neoformat_enabled_python = { "autopep8", "yapf", "docformatter" }
vim.g.neoformat_enabled_javascript = { "prettier" }
