"colorscheme mitch-old

 "#ff0000 -- test to see whether colors work

" generally good/useful things
filetype plugin indent on
set hidden
let $RTP=split(&runtimepath, ',')[0]

"source ~/.config/nvim/plugin/slets.vim
"source ~/.config/nvim/plugin/maps.vim
source ~/.config/nvim/pluginstuff.vim

" Make manpages verticalize themselves instantly
autocmd FileType help,man wincmd L

" convert markdown to html
augroup markdown
    autocmd!
    autocmd BufWritePost *.md silent !markdown % > %:r.html
augroup END

" Bring search results to center of page
nnoremap n nzz
"set nohlsearch

" re-source any .vim files when you save them
augroup bufwritepost
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END

" go to previous location
autocmd BufReadPost * silent! normal! g`"zv

" These three lines remove various unwanted forms of white space from files upon exit
" DISABLED BECAUSE IT BREAKS STUFF. USE HIGHLIGHTS INSTEAD.
"autocmd BufWritePre * %s/\s\+$//e       " Trailing spaces
"autocmd BufWritePre * %s/\n\+\%$//e     " trailing tabs
"autocmd BufWritePre *.[ch] %s/\%$/\r/e  " Trailing newlines

colorscheme mitch-old
