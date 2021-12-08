let mapleader = " "
" Bring search results to center of page
nnoremap n nzz
nnoremap N Nzz
" Janky sideways window movements
nnoremap < <C-w><
nnoremap > <C-w>>
" Clear search highlighting and errors on second esc. Also goes to 1st char.
nnoremap <esc> <Cmd>noh<CR><Bar><Cmd>echon<CR>

" Save things with doas when you really want to
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!

" useful stuff for working in terminal
tmap : <C-\><C-n>:
tmap <esc> <C-\><C-n>

" these two lines make scrolling through single-line "paragraphs" so much easier
nmap j gj
nmap k gk
" make visual replace the default
nmap R gR

" Make parentheses fun again (USE A PLUGIN FOR THIS!!!)
inoremap < <><ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ` ``<ESC>i
""inoremap ' ''<ESC>i
""inoremap " ""<ESC>i

" Double space for file switching (magic)
nnoremap <leader><leader> <c-^>

" visual stuff?
vmap < <gv
vmap > >gv

