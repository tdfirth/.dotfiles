" Plugins
call plug#begin()
" Appearance
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'tdfirth/vim-base16-lightline'
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-highlightedyank'

" Search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Language
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fireplace'

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

let g:netrw_liststyle = 3
let g:netrw_banner = 0

let g:lightline = {
            \ 'colorscheme': 'base16'
            \ }

set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

augroup matchup_matchparen_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen ctermbg=black guibg=black cterm=bold,italic gui=bold,italic
augroup END

" Keybindings
let mapleader = " "

" fzf
nnoremap <silent> <C-o> :GFiles<CR>
nnoremap <silent> <C-i> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-m> :Marks<CR>
nnoremap <C-f> :Rg<Space>
nnoremap <Leader>ss :Rg <C-R>=expand("<cword>")<CR><CR>

" Buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap <Leader>bd :bprevious<CR>:bdelete #<CR>

" Editing
nnoremap <silent> <CR> :noh<CR><CR>

" NERDTree
set mouse=a
let g:NERDTreeMouseMode=3
nnoremap <C-t> :NERDTree<CR>
autocmd StdinReadPre * let s:std_in=1

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

" Clojure

