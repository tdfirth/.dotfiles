function! neoformat#formatters#lua#enabled() abort
    return ['customluaformat']
endfunction

function! neoformat#formatters#lua#customluaformat() abort
    return {
        \ 'exe': 'lua-format',
        \ 'args': ['--indent-width=2', '--continuation-indent-width=2', '--spaces-inside-table-braces'],
        \ }
endfunction
