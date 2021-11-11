call plug#begin()
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " for modal editing in browser
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
call plug#end()

" CoC things
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-sh', 'coc-vimlsp', 'coc-pyright', 'coc-powershell']

" Hexokinase things
let g:Hexokinase_highlighters = ['foregroundfull']
" #ff0000 (test to see if the plugin actually works)

" scrollbar things
let g:scrollbar_right_offset = 0
let g:scrollbar_shape = {
  \ 'head': '❚',
  \ 'body': '█',
  \ 'tail': '❚',
  \ }
"let g:scrollbar_highlight = {
"  \ 'head': 'LineNr',
"  \ 'body': 'LineNr',
"  \ 'tail': 'LineNr',
"  \ }
let g:scrollbar_max_size = 40

"" firenvim things
if exists('g:started_by_firenvim')
    set guifont=MesloLGS\ NF:h10
    set laststatus=0
else
    set guifont=MesloLGS\ NF:h15.5
endif

" gpg things
let g:GPGUseAgent=1
let g:GPGPreferSymmetric=1
let g:GPGPreferArmor=1
let g:GPGUsePipes=1
