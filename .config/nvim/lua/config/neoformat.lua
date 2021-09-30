-- autoformat
local format_cmd = function(formatter)
  local cmd = [[try | undojoin | Neoformat ]] .. formatter ..
                [[ | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat ]] ..
                formatter .. [[ | endtry]]
  return cmd
end

require("utils").define_augroups {
  autoformat = {
    { "BufWritePre", "*.lua", format_cmd("customluaformat") },
    { "BufWritePre", "*.py", format_cmd("black") }, {
      "BufWritePre", "*.js,*.ts,*.jsx,*.tsx,*.html,*.json,*.yaml",
      format_cmd("prettier")
    }
  }
}

vim.g.neoformat_run_all_formatters = 0

vim.g.neoformat_enabled_lua = { "customluaformat" }
vim.g.neoformat_enabled_python = { "autopep8", "yapf", "docformatter" }
vim.g.neoformat_enabled_javascript = { "prettier" }
vim.g.neoformat_enabled_typescript = { "prettier" }
vim.g.neoformat_enabled_html = { "prettier" }
