source ~/.config/nvim/plugin/pluginstuff.vim
source ~/.config/nvim/plugin/slets.vim
source ~/.config/nvim/plugin/maps.vim

" generally good/useful things
filetype plugin on
filetype indent on

" Make manpages verticalize themselves instantly
autocmd FileType help,man wincmd L

" re-source any .vim files when you save them
augroup vimrc
   autocmd! BufWritePost *.vim source %
 augroup END

colorscheme mitch-old

" go to previous location
autocmd BufReadPost * silent! normal! g`"zv

" These three lines remove various unwanted forms of white space from files upon exit
autocmd BufWritePre * %s/\s\+$//e       " Trailing spaces
autocmd BufWritePre * %s/\n\+\%$//e     " trailing tabs
autocmd BufWritePre *.[ch] %s/\%$/\r/e  " Trailing newlines
