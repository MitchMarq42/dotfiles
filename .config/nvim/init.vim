" Disable slow interpreted language support plugins
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
" Ease of use thing since suspend/hibernate messes with xserver mods
silent! !xset r rate 300 50

" Maybe install vim-plug and then do plug things
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
call plug#begin()
Plug 'glacambre/firenvim' " for modal editing in browser
Plug 'Xuyuanp/scrollbar.nvim' " actually good scrollbar
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Cool color highlighting stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'tomasiser/vim-code-dark'
call plug#end()

set termguicolors
colorscheme codedark
highlight Normal guibg=none
highlight LineNr guibg=none guifg=blue gui=none
highlight CursorLineNr guibg=none guifg=lightblue gui=bold

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
  \ 'head': 'Comment',
  \ 'body': 'Comment',
  \ 'tail': 'Comment',
  \ }
let g:scrollbar_max_size = 40

filetype plugin on
filetype indent on
let mapleader="\\"
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
" Clear highlighting from search results on second esc and redraw status bar
nnoremap <esc> :noh<return>
" Make manpages verticalize themselves instantly
autocmd FileType help,man wincmd L
" Fix control+W keys to be easier to use (splits)
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
" these two lines make scrolling through single-line "paragraphs" so much
" easier
nmap j gj
nmap k gk
" make 0 and $ easier
nnoremap gl $
nnoremap gh 0
" make visual replace the default
nmap R gR
" save and quit all tabs and buffers on ZZ; avoids 'only floating windows
" left' error (but not readonly errors)
nnoremap ZZ :wqa<return>
" start with statusbar enabled
set laststatus=2
" fix tab indentation being weird
set tabstop=4
set shiftwidth=4
set expandtab
" learn to control autocommenting
set formatoptions-=cro

" Hide bottom status line while in terminal
augroup hidebar
	autocmd!
	autocmd TermOpen,TermEnter silent! set laststatus=0
	"autocmd TermClose silent! set laststatus=2
augroup end

" go to previous location
autocmd BufReadPost * silent! normal! g`"zv
" Save things with doas when you really want to
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
autocmd BufWritePre * %s/\s\+$//e      " These three lines remove various
autocmd BufWritePre * %s/\n\+\%$//e    " unwanted forms of white space
autocmd BufWritePre *.[ch] %s/\%$/\r/e " from files upon exit
highlight link Scrollbar Comment

"let g:airline_left_sep=''
let g:airline_inactve_collapse=1
let g:airline_powerline_fonts=1
let g:airline_theme="codedark"
" base16_tube
" base16_colors
" base16_isotope
" tomorrow
" base16_summerfruit
" jet

" Man page stuff that doesn't work
if &ft ==? "help"
	nmap <silent> <buffer> <nowait> q :q!
	" The above usually doesn't work, nor does it accomplish the right
	" thing. Instead, modify the file
	" /usr/share/nvim/runtime/ftplugin/man.vim.
endif
