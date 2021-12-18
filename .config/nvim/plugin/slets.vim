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
set signcolumn=number
set noswapfile undofile undodir=~/.cache/nvim/undo
set nobackup nowritebackup
set lazyredraw
set scrolloff=3
set splitbelow splitright
set shortmess+=c
set wildmode=longest,full
set ignorecase smartcase incsearch hlsearch
set viminfo='10,\"100,:20,%,n~/.cache/nvim/viminfo
set hidden
set completeopt=menuone,noinsert,noselect

"set cursorline cursorcolumn SLOW AF

set noshowmode laststatus=2 cmdwinheight=1
" fix tab indentation being weird
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
" control autocommenting (broken)
set formatoptions-=cro

" airline things (more in colors file)
let g:airline_left_sep=''
let g:airline_right_sep=''

" Plugin settings. Moved because reasons.
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-sh', 'coc-vimlsp', 'coc-pyright', 'coc-powershell']
let g:scrollbar_right_offset = 0
let g:scrollbar_max_size = 40
let g:scrollbar_shape = {
  \ 'head': '❚',
  \ 'body': '█',
  \ 'tail': '❚',
  \ }
