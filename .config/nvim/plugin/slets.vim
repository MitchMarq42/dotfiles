" Disable slow interpreted language support plugins
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_pythonx_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
set pyx=3

" generally good/useful things
set linebreak
set encoding=utf-8
set mouse=a
set number relativenumber
set noswapfile
set nobackup nowritebackup
set undodir=~/.cache/nvim/undo
set undofile
set lazyredraw
set scrolloff=3
set splitbelow splitright
set cmdwinheight=1
"set wildmode=longest,list,full
set ignorecase smartcase
set incsearch hlsearch
set viminfo='10,\"100,:20,%,n~/.cache/nvim/viminfo
set termguicolors

" start with statusbar enabled
set laststatus=2
" fix tab indentation being weird
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
" control autocommenting
set formatoptions-=cro
