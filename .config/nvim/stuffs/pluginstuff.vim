" Maybe install vim-plug and then do plug things
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
call plug#begin()
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " for modal editing in browser
Plug 'ervandew/supertab' " dumb tab complete that doesn't really work but should
Plug 'Xuyuanp/scrollbar.nvim' " actually good scrollbar
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
