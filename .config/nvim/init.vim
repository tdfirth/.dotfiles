" Plugins
call plug#begin()
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'tdfirth/nord-vim', {'branch': 'develop'}

" Search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'branch': 'release/0.x' }
Plug 'vim-erlang/vim-erlang-runtime'

" Tools
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'

call plug#end()

" UI
set termguicolors

function! s:ReloadTheme()
  runtime theme.vim
  if g:theme == "nordl"
    colorscheme nordl
  else
    colorscheme nordd
  endif
  let g:lightline = {
              \ 'colorscheme': g:theme
              \ }
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

call s:ReloadTheme()

augroup UISettings
  autocmd!
  autocmd FileType qf wincmd J
  command! ReloadTheme call s:ReloadTheme()
augroup END

" Editor
set shell=/usr/bin/env\ bash
set noshowcmd
set updatetime=300
set number relativenumber
set clipboard+=unnamedplus
set splitbelow
set splitright
set shortmess+=c
set signcolumn=yes
set hidden
set autoread
set incsearch
set wildmenu
set mouse=a
set cursorline
set noexpandtab
set showmatch
set scrolloff=999
set list
set listchars=tab:›\ ,eol:¬,trail:⋅
set backspace=indent,eol,start
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

" Completion 
set wildmode=list:longest " Wildcard matches show a list, matching the longest first
set wildignore+=.git      " Ignore version control repos
set wildignore+=*.pyc     " Ignore Python compiled files
set wildignore+=*.swp     " Ignore vim backups

" Reload files when change detected.
augroup filereloader
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" Keybindings
" Makes navigating wrapped lines feel more natural.
map j gj
map k gk

let mapleader = " "
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-j> <c-w>j
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-p> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>ff :NERDTreeFind<CR>
nnoremap <silent> <Leader>rt :ReloadTheme<CR>

" fzf
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <Leader><Leader> :GFiles --cached --others --exclude-standard<CR>
nnoremap <silent> <Leader>m :Marks<CR>
nnoremap <C-_> :Rg<Space>
nnoremap <silent> <C-Space> yiw:Rg <C-r>"<CR>
vnoremap <silent> <C-Space> y:Rg <C-r>"<CR>

let g:fzf_layout = { 'down': '40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Buffers
nnoremap <silent> <Leader>p :bn<CR>
nnoremap <silent> <Leader>n :bp<CR>
nnoremap <silent> <Leader>k :bprevious<CR>:bdelete #<CR>

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

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Fugitive
nnoremap <silent> <Leader>gs :vertical Git<CR>

" Python
augroup python-config
  autocmd!
  au BufNewFile,BufRead *.py
    \ setlocal expandtab       |
    \ setlocal tabstop=4       |
    \ setlocal softtabstop=4   |
    \ setlocal shiftwidth=4    |
    \ setlocal autoindent      |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=79
  autocmd BufWritePre *.py execute ':Black'
  nmap <silent> <Leader>lb :norm oimport ipdb; ipdb.set_trace()<esc>:w<CR>
augroup END

" Go
augroup go-config
  autocmd!
  au BufNewFile,BufRead *.go
    \ setlocal noexpandtab     |
    \ setlocal tabstop=4       |
    \ setlocal softtabstop=4   |
    \ setlocal shiftwidth=4    |
    \ setlocal autoindent      |
    \ setlocal smartindent     |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=100
  let g:go_highlight_diagnostic_errors = 0
  let g:go_highlight_diagnostic_warnings = 0
  let g:go_auto_type_info = 1
  let g:go_list_height = 10
  let g:go_fmt_command = "golines"
  let g:go_fmt_options = {
      \ 'golines': '-m 100 --base-formatter gofmt',
      \ }
  au FileType go nmap <buffer> <silent> <Leader>lb <Plug>(go-build)
  au FileType go nmap <buffer> <silent> <Leader>ld <Plug>(go-def) 
  au FileType go nmap <buffer> <silent> <Leader>li <Plug>(go-imports) 
  au FileType go nmap <buffer> <silent> <Leader>lr <Plug>(go-rename) 
  au FileType go nmap <buffer> <silent> <Leader>ltt <Plug>(go-test)
  au FileType go nmap <buffer> <silent> <Leader>ltf <Plug>(go-test-func)
augroup END

" Web
augroup web-config
  autocmd!
  au BufNewFile,BufRead *.js,*.html,*.css
    \ setlocal expandtab       |
    \ setlocal tabstop=2       |
    \ setlocal softtabstop=2   |
    \ setlocal shiftwidth=2    |
    \ setlocal autoindent      |
    \ setlocal fileformat=unix
augroup END

" Markdown
augroup md-config
  autocmd!
  au BufNewFile,BufRead *.md
    \ setlocal expandtab       |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=80  |
    \ setlocal textwidth=80
augroup md-config

" Protobuf
augroup proto-config
  autocmd!
  au BufNewFile,BufRead *.proto
    \ setlocal expandtab       |
    \ setlocal tabstop=2       |
    \ setlocal softtabstop=2   |
    \ setlocal shiftwidth=2    |
    \ setlocal autoindent      |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=80
augroup END

" Erlang
augroup erlang-config
  autocmd!
  au BufNewFile,BufRead *.erl
    \ setlocal expandtab       |
    \ setlocal tabstop=4       |
    \ setlocal softtabstop=4   |
    \ setlocal shiftwidth=4    |
    \ setlocal autoindent      |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=80
augroup END

" Bash
augroup bash-config
  autocmd!
  au BufNewFile,BufRead *.sh,*.bash
    \ setlocal expandtab       |
    \ setlocal tabstop=4       |
    \ setlocal softtabstop=4   |
    \ setlocal shiftwidth=4    |
    \ setlocal autoindent      |
    \ setlocal fileformat=unix |
    \ setlocal colorcolumn=80
augroup END
