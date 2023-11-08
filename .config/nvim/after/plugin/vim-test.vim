let test#strategy = { 'nearest': 'dispatch', 'file': 'dispatch', 'suite': 'dispatch' }

function! SetNxProject()
  let filename = expand('%')
  let nx_project = matchstr(filename, '\(apps\|libs\)\/\zs.*\ze\/src\/.*.ts')
  if nx_project != ""
    let g:test#javascript#nx#project = nx_project
  endif
endfunction

augroup vim_test
    autocmd!
    autocmd BufEnter *.ts :call SetNxProject()
    autocmd BufEnter *.tsx :call SetNxProject()
augroup END
