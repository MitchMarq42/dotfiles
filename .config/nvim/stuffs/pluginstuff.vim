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
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/scrollbar.nvim' " actually good scrollbar
Plug 'vim-airline/vim-airline' " Semi shitty but pretty epic statusline
Plug 'vin-airline/vim-airline-themes' " themes for above
Plug 'mattn/emmet-vim' " Magic HTML IDE thingy
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Cool color highlighting stuff
call plug#end()

" Supertab things
"let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
" Hexokinase things
let g:Hexokinase_highlighters = ['backgroundfull']
" scrollbar things
augroup ScrollbarInit
	autocmd!
	autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
	autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
	autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup end
let g:scrollbar_right_offset = 0
let g:scrollbar_shape = {
  \ 'head': '█',
  \ 'body': '█',
  \ 'tail': '█',
  \ }
let g:scrollbar_highlight = {
  \ 'head': 'VertSplit',
  \ 'body': 'VertSplit',
  \ 'tail': 'VertSplit',
  \ }
let g:scrollbar_max_size = 40

"CoC things (currently disabled because it's slow etc)
"command! -nargs=0 Prettier :CocCommand prettier.formatFile
"let g:coc_global_extensions = [
"            \'coc-snippets',
"            \'coc-pairs',
"            \'coc-prettier',
"            \'coc-tsserver',
"            \'coc-html',
"            \'coc-css',
"            \'coc-json',
"            \]
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
