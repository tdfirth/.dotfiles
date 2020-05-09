" Plugins
call plug#begin()
" Appearance
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-highlightedyank'

" Search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

set shell=/bin/bash
set noshowcmd
set updatetime=300
set number relativenumber
set clipboard+=unnamedplus
set splitbelow
set splitright
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set shortmess+=c
set signcolumn=yes

" Keybindings
nnoremap ; :
let mapleader = " "

" fzf
nnoremap <silent> <C-o> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<Space>
nnoremap <Leader>ss :Rg <C-R>=expand("<cword>")<CR><CR>

" Buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Editing
nnoremap <Leader>h :noh<CR>

" Panes
nnoremap <Leader>sv :vsp<CR>
nnoremap <Leader>sh :sp<CR>

" Coc
" Autocomplete navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
       call CocAction('doHover')
  endif
endfunction

" Format
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OptimiseImports :call CocAction('runCommand', 'editor.action.organizeImport')

" Rename
command! -nargs=0 RenameSymbol :call CocActionAsync('rename')
nnoremap <silent><Leader>rn :RenameSymbol<CR>

" Navigate Diagnostics
nmap <silent> <Leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>dn <Plug>(coc-diagnostic-next)

" Rust

" Python
