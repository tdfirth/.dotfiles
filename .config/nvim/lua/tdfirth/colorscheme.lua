vim.cmd [[
try
  colorscheme herdwick
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
