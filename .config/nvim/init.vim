" Ease of use thing since suspend/hibernate messes with xserver mods
"silent! !xset r rate 300 50
source ~/.config/nvim/stuffs/pluginstuff.vim
source ~/.config/nvim/stuffs/slets.vim
source ~/.config/nvim/stuffs/maps.vim

" generally good/useful things
filetype plugin on
filetype indent on
let mapleader="\\"

" Make manpages verticalize themselves instantly
autocmd FileType help,man wincmd L

" re-source any .vim files when you save them
augroup vimrc
   autocmd! BufWritePost *.vim source %
 augroup END

colorscheme mitch-old

" go to previous location
autocmd BufReadPost * silent! normal! g`"zv
" Save things with doas when you really want to
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!
autocmd BufWritePre * %s/\s\+$//e      " These three lines remove various
autocmd BufWritePre * %s/\n\+\%$//e    " unwanted forms of white space
autocmd BufWritePre *.[ch] %s/\%$/\r/e " from files upon exit

" Markdown stuff?
if &ft ==? "markdown"
endif

if exists('g:started_by_firenvim')
    set guifont=MesloLGS\ NF:h10.5
    set laststatus=0
else
    set guifont=MesloLGS\ NF:h15.5
endif
