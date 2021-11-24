call plug#begin()
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
