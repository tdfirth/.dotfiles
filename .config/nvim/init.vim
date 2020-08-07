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

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'elixir-editors/vim-elixir'

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

" Panes
nnoremap <Leader>sv :vsp<CR>
nnoremap <Leader>sh :sp<CR>

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
nmap <silent> <Leader>pb :norm oimport ipdb; ipdb.set_trace()<esc>:w<CR>

