let mapleader = " "
" Clear search highlighting and errors on second esc. Also goes to 1st char.
nnoremap <esc> <Cmd>noh<CR><Bar><Cmd>echon<CR>

" Save things with doas when you really want to
cnoremap w!! execute 'silent! write !doas tee % >/dev/null' <bar> edit!

" Fix control+W keys to be easier to use (splits)
"nmap <C-h> <C-w>h
"nmap <C-l> <C-w>l
"nmap <C-j> <C-w>j
"nmap <C-k> <C-w>k
" these two lines make scrolling through single-line "paragraphs" so much
" easier
nmap j gj
nmap k gk
" make 0 and $ easier
"nnoremap gl $
"nnoremap gh 0
" make visual replace the default
nmap R gR
" save and quit all tabs and buffers on ZZ; avoids 'only floating windows
" left' error (but not readonly errors) (disabled because reasons)
"nnoremap ZZ :wqa<return>
"
" Don't press shift again! (disabled because I kept pressing shift anyway)
" nnoremap ; :

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
