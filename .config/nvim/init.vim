" generally good/useful things
filetype plugin indent on

"source ~/.config/nvim/plugin/slets.vim " done automatically
"source ~/.config/nvim/plugin/maps.vim  " by vim runtime
lua require('pluginstuff')

" Make manpages verticalize themselves instantly
autocmd FileType help,man wincmd L

" Bring search results to center of page
nnoremap n nzz
nnoremap N Nzz
"set nohlsearch

" These three lines remove various unwanted forms of white space from files upon exit
" DISABLED BECAUSE IT BREAKS STUFF. USE HIGHLIGHTS INSTEAD.
"autocmd BufWritePre * %s/\s\+$//e       " Trailing spaces
"autocmd BufWritePre * %s/\n\+\%$//e     " trailing tabs
"autocmd BufWritePre *.[ch] %s/\%$/\r/e  " Trailing newlines

colorscheme mitch
let g:airline_theme='ravenpower'

" EXPERINENTAL FEATURE. WILL NOT WORK IN YOUR VIM.
silent set cmdheight=0
