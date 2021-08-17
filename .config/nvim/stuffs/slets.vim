" Disable slow interpreted language support plugins
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" generally good/useful things
set linebreak
set encoding=utf-8
set mouse=a
set number
set relativenumber
set lazyredraw
set scrolloff=3
set splitbelow splitright
set cmdwinheight=1
set wildmode=longest,list,full
set viminfo='10,\"100,:20,%,n~/.viminfo

" start with statusbar enabled
set laststatus=2
" fix tab indentation being weird
set tabstop=4
set shiftwidth=4
set expandtab
" control autocommenting
set formatoptions-=cro