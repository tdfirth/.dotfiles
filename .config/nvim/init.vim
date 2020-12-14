" Plugins
call plug#begin()
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'

" Search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Tools
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'

call plug#end()

" UI
colorscheme nord
set termguicolors
let g:nord_italic_comments = 1
let g:lightline = {
            \ 'colorscheme': 'nord'
            \ }
augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight QuickFixLine ctermfg=15 guifg=#ECEFF4 ctermbg=0 guibg=#3B4252
augroup END

let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Editor
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
set hidden
set autoread
set colorcolumn=80
set incsearch
set wildmenu
set mouse=a
set cursorline

" Always open the quick fix list full width at the bottom.
autocmd FileType qf wincmd J

" Reload files when change detected.
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Keybindings
let mapleader = " "
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l

" fzf
nnoremap <silent> <C-o> :GFiles<CR>
nnoremap <silent> <C-i> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-m> :Marks<CR>
nnoremap <C-f> :Rg<Space>

" Buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap <Leader>bd :bprevious<CR>:bdelete #<CR>

" Editing
nnoremap <silent> <CR> :noh<CR><CR>

" FZF
function! s:copy_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @+ = joined_lines
endfunction
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-o': function('s:copy_results'),
  \ }

" Python
nmap <silent> <Leader>pb :norm oimport ipdb; ipdb.set_trace()<esc>:w<CR>

" GO
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_list_height = 10

