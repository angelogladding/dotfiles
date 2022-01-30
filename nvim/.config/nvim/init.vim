call plug#begin('~/.config/nvim/plugged')
Plug 'w0rp/ale'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'altercation/vim-colors-solarized'
Plug 'google/vim-coverage'
Plug 'tpope/vim-fugitive'
Plug 'google/vim-maktaba'
Plug 'Lokaltog/vim-powerline'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
call plug#end()

filetype plugin indent on
syntax on
colorscheme solarized

set background=dark
" set background=light

" set t_Co=256
" if !has('gui_running')
"   set t_Co=16
"   let g:solarized_termcolors=&t_Co
"   let g:solarized_termtrans=1
" endif

set autoindent
set backspace=indent,eol,start  " allow backspacing over everything
set colorcolumn=89
set completeopt=menuone,longest,preview
set cursorline
set encoding=utf-8
set expandtab
set foldlevel=9
set foldmethod=indent
set formatoptions=qrn1
set gdefault
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:▸\ ,eol:¬
set modelines=0
set mouse=a
set nocompatible
set noswapfile
set relativenumber
set ruler
set scrolloff=4
set shiftwidth=4
set showcmd  "display incomplete commands
set showmatch
set showmode
set smartcase
set softtabstop=4
set tabstop=4
set textwidth=79
set ttyfast
set undofile
set visualbell
set wildmenu
set wildmode=list:longest
set wrap

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

nnoremap ; :

nnoremap <space> za

nnoremap <tab> %
vnoremap <tab> %

nnoremap / /\v
vnoremap / /\v 

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

nnoremap <C-h> <C-w>h <C-w>_
nnoremap <C-j> <C-w>j <C-w>_
nnoremap <C-k> <C-w>k <C-w>_
nnoremap <C-l> <C-w>l <C-w>_

nnoremap j gj
nnoremap k gk

noremap <A-j> :m+<CR>
noremap <A-k> :m-2<CR>
inoremap <A-j> <Esc>:m+<CR>
inoremap <A-k> <Esc>:m-2<CR>
vnoremap <A-j> :m'>+<CR>gv
vnoremap <A-k> :m-2<CR>gv

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

let mapleader=","
nnoremap <leader><space> :noh<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>s :mksession!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" nnoremap <leader>r :w<CR> :silent !~/.poetry/bin/poetry version prerelease<CR>
nnoremap <leader>r :w <bar> :silent !~/.poetry/bin/poetry version prerelease<CR>
" :cd ~/Working/angelogladding.com<CR>:silent !~/.poetry/bin/poetry update && touch pyproject.toml<CR>:cd %:p:h<CR>
nnoremap <leader>sq :qa<CR>
nnoremap <leader>e :ALENext<CR>
nnoremap <leader>- <C-w>_
nnoremap <leader>d :NERDTreeToggle<CR>
map <leader>x <Plug>TaskList

let g:indieweb_micropub_endpoint='https://working.angelogladding.com/pub'
let g:indieweb_access_token='abc123'

let g:limelight_conceal_ctermfg = 'green'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" let g:syntastic_auto_loc_list=1
" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_check_on_open=1

let g:Powerline_symbols = 'fancy'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" let g:solarized_visibility = "low"
call togglebg#map("<F5>")

let test#strategy = "neovim"
let g:test#runner_commands = ['PyTest', 'Mocha']
nnoremap <leader>t :TestFile<CR>

let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint']
let g:ale_linters.typescript = ['eslint']
let g:ale_linters.python = ['flake8', 'pyright']
let g:ale_linters.html = []  " 'htmlhint']
" 'css': ['stylelint’],
" let b:ale_python_pyright_config = {
" \ 'pyright': {
" \   'reportGeneralTypeIssues': "none",
" \ },
" \}
let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_warn_about_trailing_whitespace = 0

let g:ale_completion_enabled = 1

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.typescript = ['eslint']
let g:ale_fixers.python = ['black', 'isort']
let g:ale_fixers.html = []  " 'tidy']
let g:ale_fix_on_save = 1

let g:ale_sign_error = "🐛"
let g:ale_sign_warning = "⚠️"
let g:ale_sign_info = "ℹ"

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "🔥 "

" nnoremap <leader>r :silent !curl http://localhost:9000/index.html?processname=interface\%3Aapplication&action=restart<CR><C-l>
" nnoremap <leader>r :silent !kill -hup `cat /gunicorn.pid`<CR><C-l>
" nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" nnoremap <leader>f :QFix<CR>
" nnoremap <leader>g :GundoToggle<CR>
" nnoremap <leader>m :MakeGreen<CR>
" nnoremap <leader>g :Pytest project<CR>
" nnoremap <leader>ch :PyCoverageHighlight<CR>
" nnoremap <leader>cc :PyCoverageClear<CR>
" nnoremap <leader>cq :PyCoverageSetQuickfix<CR>
" nnoremap <leader>cl :PyCoverageSetLoclist<CR>

" " set fillchars+=stl: ,stlnc:
" let g:Powerline_mode_V="V·LINE"
" let g:Powerline_mode_cv="V·BLOCK"
" let g:Powerline_mode_S="S·LINE"
" let g:Powerline_mode_cs="S·BLOCK"
" 
" set guifont=Liberation_Mono_for_Powerline:h10
" " set guifont=Liberation Mono for Powerline 10
" 
" let g:airline_powerline_fonts = 1

" set showtabline=2 " Always display the tabline, even if there is only one tab
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" autocmd FileType python PyCoverageHighlight
" autocmd FileType python PyCoverageSetQuickfix
" autocmd FileType python PyCoverageSetLoclist
" hi PyCoverageMissed gui=undercurl guisp=Green

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let &statusline='%F%m%r%h%w [FORMAT=%{&ff}] [ENC=%{&fileencoding}] [TYPE=%Y] [ASCII=\%03.3b] [HEX=\%02.2B] [POS=%04l,%04v][%p%%] [LEN=%L] %= [WORKON=%{pythonworkon}]'

" command! -nargs=1 WriteThenSilent
" \ | execute ':w'
" \ | execute ':silent !'.<q-args>
" \ | execute ':redraw!'
" nnoremap <leader>m :WriteThenSilent make docs<CR>
