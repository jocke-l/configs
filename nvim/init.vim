""" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'

""" Plug 'preservim/nerdtree'
""" Delete when merged
Plug 'santiagovrancovich/nerdtree', {'commit': '1b8b61c12a0b91b6f354afe151634600b49b4cca'}

Plug 'dracula/vim', {'as':'dracula'}

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'itchyny/lightline.vim'

Plug 'sheerun/vim-polyglot'

Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jeetsukumaran/vim-indentwise'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


""" Misc
syntax enable

set termguicolors
set number rnu
set hidden
set nowrapscan
set mouse=a
set incsearch
set clipboard=unnamedplus

""" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent


""" Fast Command line
nnoremap ; :
xnoremap ; :


""" Omni competion
filetype plugin on
set omnifunc=syntaxcomplete#Complete


""" Navigation
nnoremap <Leader>tf :NERDTreeFind<CR>
nnoremap <Leader>tt :NERDTreeToggle<CR>

nnoremap <silent> <Leader>\ :nohl<CR>

nnoremap <Leader>qw :Window<CR>
nnoremap <Leader>qb :Buffer<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>ww <C-w>w
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vsplit<CR>


""" Linting
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_open_list = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_list_window_size = 5

let g:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['eslint'], 'terraform': ['terraform'] }
let g:ale_linters = {'javascript': ['eslint'], 'terraform': ['tflint'], 'python': ['flake8', 'mypy'] }


""" LSP

inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() :
        \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


""" Theme
colorscheme dracula

set colorcolumn=89
set cursorline
"set cursorcolumn
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }
