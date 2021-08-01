set termguicolors

" This is a comment for some reason
hi clear
highlight lineNr    guibg=none   guifg=#1010ff   gui=none
highlight CursorLineNr  guibg=none   guifg=#ff0000   gui=bold
highlight Comment   guibg=none      guifg=#00bf00     gui=none

highlight Statement     guibg=none      guifg=#00aaaf   gui=bold
highlight PreProc   guibg=none      guifg=#ffaf00   gui=none
highlight Type  guibg=none      guifg=#ff0f0f       gui=bold
highlight Constant  guibg=none  guifg=#0f6fff       gui=none
highlight StatusLineNc  guibg=#600000   guifg=white gui=none
highlight VertSplit     guibg=none      guifg=#600000   gui=bold

highlight StatusLine    guibg=#600000   guifg=white gui=bold

set statusline=%#StatusLine#%t%r%m%=%y\ [%l:%v]
