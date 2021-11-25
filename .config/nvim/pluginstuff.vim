call plug#begin()
<<<<<<< HEAD
Plug 'glacambre/firenvim', { 'do': { _ -> silent firenvim#install(0) } } " for modal editing in browser
Plug 'mattn/emmet-vim' " Magic HTML IDE thingy
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Actually cool color highlighting stuff
Plug 'Xuyuanp/scrollbar.nvim' " actually good scrollbar
Plug 'vim-airline/vim-airline' " sorta epic statusline
Plug 'vim-airline/vim-airline-themes' " themes for above
" Plug 'kyazdani42/nvim-web-devicons' " Icons that work in lua
" Plug 'lewis6991/gitsigns.nvim' " Lua git thingies
Plug 'nvim-lua/completion-nvim'
Plug 'numToStr/Comment.nvim'
Plug 'pprovost/vim-ps1'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " they recommend updating the parsers on update
Plug 'olimorris/onedarkpro.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'jamessan/vim-gnupg'
=======
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }                   " for modal editing in browser
Plug 'mattn/emmet-vim'                                                              " Magic HTML IDE thingy
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }                           " Actually cool color highlighting stuff
Plug 'Xuyuanp/scrollbar.nvim'                                                       " actually good scrollbar
Plug 'vim-airline/vim-airline'                                                      " sorta epic statusline
Plug 'vim-airline/vim-airline-themes'                                               " themes for above
Plug 'pprovost/vim-ps1'                                                             " PowerShell highlighting etc
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                         " Better highlighting?
Plug 'hrsh7th/cmp-nvim-lsp'                                                         "    These four
Plug 'hrsh7th/cmp-buffer'                                                           "    probably do
Plug 'hrsh7th/nvim-cmp'                                                             "    something, but I'm
Plug 'nvim-lua/completion-nvim'                                                     "    not sure what
Plug 'MunifTanjim/nui.nvim'                                                         " Dependency of following:
Plug 'VonHeikemen/fine-cmdline.nvim'                                                " Floating Ex command line (:)
Plug 'VonHeikemen/searchbox.nvim'                                                   " Floating Search box (/)
>>>>>>> 05aac2c7be5d4d71ca576ef1a516c92d7f6e70f4
call plug#end()

nnoremap : <cmd>lua require('fine-cmdline').open()<CR>
nnoremap / <cmd>lua require('searchbox').incsearch()<CR>

" Hexokinase things
let g:Hexokinase_highlighters = ['backgroundfull']
" #ff0000 (test to see if the plugin actually works)

"" firenvim/gui things
if exists('g:started_by_firenvim')
    set guifont=MesloLGS\ NF:h10
    set laststatus=0
else
    set guifont=MesloLGS\ NF:h15.5
endif

lua <<EOF
EOF
