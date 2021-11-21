call plug#begin()
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }                   " for modal editing in browser
Plug 'mattn/emmet-vim'                                                              " Magic HTML IDE thingy
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }                           " Actually cool color highlighting stuff
Plug 'Xuyuanp/scrollbar.nvim'                                                       " actually good scrollbar
Plug 'vim-airline/vim-airline'                                                      " sorta epic statusline
Plug 'vim-airline/vim-airline-themes'                                               " themes for above
Plug 'nvim-lua/completion-nvim'                                                     " probably does something
Plug 'pprovost/vim-ps1'                                                             " PowerShell highlighting etc
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                         " Better highlighting?
Plug 'hrsh7th/cmp-nvim-lsp'                                                         " These three probably
Plug 'hrsh7th/cmp-buffer'                                                           " do something, but I'm
Plug 'hrsh7th/nvim-cmp'                                                             " not sure what
Plug 'MunifTanjim/nui.nvim'                                                         " For floating command line etc.
Plug 'VonHeikemen/fine-cmdline.nvim'                                                " Disable if you don't have cmdheight=0 patch.
call plug#end()

nnoremap : <cmd>lua require('fine-cmdline').open()<CR>

" Hexokinase things
let g:Hexokinase_highlighters = ['foregroundfull']
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
