" Maybe install vim-plug and then do plug things
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin()
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " for modal editing in browser
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/scrollbar.nvim' " actually good scrollbar
Plug 'vim-airline/vim-airline' " sorta epic statusline
Plug 'vim-airline/vim-airline-themes' " themes for above
Plug 'mattn/emmet-vim' " Magic HTML IDE thingy
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Actually cool color highlighting stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " they recommend updating the parsers on update
Plug 'ervandew/supertab' " super tab complete? (not super, just tab)
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " main one
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ Snippets
call plug#end()

" airline things (more in colors file)
set noshowmode
let g:airline_left_sep=''
let g:airline_right_sep=''

" Hexokinase things
let g:Hexokinase_highlighters = ['foregroundfull']
"HexokinaseTurnOn
" #ff0000 (test to see if the plugin actually works)

" scrollbar things
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup end
let g:scrollbar_right_offset = 0
let g:scrollbar_shape = {
  \ 'head': '⣿',
  \ 'body': '⣿',
  \ 'tail': '⣿',
  \ }
let g:scrollbar_highlight = {
  \ 'head': 'LineNr',
  \ 'body': 'LineNr',
  \ 'tail': 'LineNr',
  \ }
let g:scrollbar_max_size = 40

"" firenvim things
if exists('g:started_by_firenvim')
    set guifont=MesloLGS\ NF:h10
    set laststatus=0
else
    set guifont=MesloLGS\ NF:h15.5
endif

" coq
"COQnow [--shut-up]

" LSP, COQ things
lua << EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {"html", "css", "json", "bash", "rust", "haskell", "regex", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "vim" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
