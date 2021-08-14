" Clear highlighting from search results on second esc
nnoremap <esc> :noh<return>

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
nnoremap gl $
nnoremap gh 0
" make visual replace the default
nmap R gR
" save and quit all tabs and buffers on ZZ; avoids 'only floating windows
" left' error (but not readonly errors) (disabled because reasons)
"nnoremap ZZ :wqa<return>

" Make parentheses fun again
inoremap < <><ESC>ha
inoremap ( ()<ESC>ha
inoremap [ []<ESC>ha
inoremap { {}<ESC>ha
inoremap ` ``<ESC>ha
