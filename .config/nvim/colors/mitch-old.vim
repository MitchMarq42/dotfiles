"black    =  0  =  8
"red      =  1  =  9
"green    =  2  =  10
"yellow   =  3  =  11
"blue     =  4  =  12
"magenta  =  5  =  13
"cyan     =  6  =  14
"white    =  7  =  15

" A color scheme made to emulate the SV colors (https://github.com/alexkh/vimcolors),
" but without requiring termguicolors to be enabled. Instead, manually
" set your terminal's first 8 colors to the correct ones that look
" right. This ensures that they look right.

" EDIT: ack screw it im using termguicolors they work
" EDIT2: Gonna fill this in completely some time with all the possible values
" for colors and stuff. Probs not for a while though.

" hi	  thing		    	guibg	    	guifg	       	gui		    ctermbg		ctermfg		        cterm
hi clear
"set background=dark
set termguicolors
highlight Normal	    	guibg=#000000	guifg=#bbbb77	gui=none	ctermbg=0   ctermfg=11          cterm=none
highlight Comment  	    	guibg=none    	guifg=green		gui=none	ctermbg=0   ctermfg=2           cterm=none
highlight NonText 	    	guibg=none      guifg=brown     gui=bold    ctermbg=0   ctermfg=13          cterm=bold
highlight Constant          guibg=none  	guifg=#0077ff	gui=none 	ctermbg=0   ctermfg=12	        cterm=none
highlight cString 	    	guibg=none      guifg=white 	gui=bold 	ctermbg=0   ctermfg=7       	cterm=bold
highlight cCppString    	guibg=none  	guifg=white 	gui=bold	ctermbg=0   ctermfg=7       	cterm=bold
highlight cBracket 	    	guibg=red   	guifg=#cccc66   gui=bold 	ctermbg=1  	ctermfg=darkyellow  cterm=bold
highlight Identifier    	guibg=none  	guifg=#00c0c0	gui=none    ctermbg=0   ctermfg=14          cterm=none
highlight Statement	    	guibg=none      guifg=#c0c000	gui=bold	ctermbg=0   ctermfg=3        	cterm=bold
highlight PreProc  	    	guibg=none      guifg=#0088ff	gui=bold    ctermbg=0   ctermfg=lightblue   cterm=bold
highlight Type		    	guibg=none      guifg=orange	gui=bold	ctermbg=0   ctermfg=2           cterm=bold
highlight Special       	guibg=none      guifg=#bb00bb	gui=bold    ctermbg=0	ctermfg=12          cterm=bold
highlight Error		    	guibg=#ff0000   guifg=white		gui=none    ctermbg=9   ctermfg=white       cterm=none
highlight Todo		    	guibg=#c0c000	guifg=#000080	gui=none    ctermbg=3	ctermfg=4           cterm=none
highlight Directory	    	guibg=none	    guifg=#00c000	gui=bold	ctermbg=0	ctermfg=10          cterm=bold
highlight Search	    	guibg=#c0c000	guifg=black     gui=none    ctermbg=3   ctermfg=black       cterm=none
highlight operator 	    	guibg=none   	guifg=pink      gui=none    ctermbg=0   ctermfg=13          cterm=none
highlight statement	    	guibg=none      guifg=red	    gui=bold	ctermbg=0	ctermfg=1           cterm=bold
highlight DiffAdd 	    	guibg=purple 	guifg=black	    gui=bold    ctermbg=5   ctermfg=0           cterm=bold
highlight DiffChange    	guibg=green 	guifg=black	    gui=bold    ctermbg=2   ctermfg=0           cterm=bold
highlight DiffDelete    	guibg=red    	guifg=black	    gui=bold    ctermbg=1   ctermfg=0           cterm=bold
highlight DiffText 	    	guibg=orange 	guifg=black	    gui=bold    ctermbg=9   ctermfg=7           cterm=bold
highlight MsgSeparator  	guibg=blue  	guifg=white	    gui=bold    ctermbg=4   ctermfg=7           cterm=bold
highlight CursorLine    	guibg=#303030
highlight CursorColumn  	guibg=#303030
highlight VertSplit     	guibg=none   	guifg=purple	gui=bold    ctermbg=0   ctermfg=5           cterm=bold
highlight RevComment    	guibg=green 	guifg=black 	gui=none    ctermbg=2   ctermfg=black       cterm=none
highlight RevStatLn     	guibg=red   	guifg=black	    gui=bold    ctermbg=1   ctermfg=0           cterm=bold
highlight CmdMode 	    	guibg=white 	guifg=black	    gui=bold    ctermbg=7   ctermfg=black       cterm=bold
highlight TabLineSel    	guibg=orange 	guifg=black	    gui=bold    ctermbg=9   ctermfg=0           cterm=bold
highlight LineNr            guibg=none      guifg=yellow    gui=none    ctermbg=0   ctermfg=3           cterm=none
highlight CursorLineNr      guibg=black     guifg=yellow    gui=bold
highlight StatusLine        guibg=blue      guifg=white     gui=bold    ctermbg=4   ctermfg=11          cterm=bold
highlight NonText           guibg=black     guifg=red
highlight Pmenu             guibg=#303030   guifg=#a0a0f0
highlight TabLine 	    	guibg=green 	guifg=black
highlight GreenGreen    	guibg=green 	guifg=green
highlight PurplePurple  	guibg=purple 	guifg=purple
highlight OrangeOrange  	guibg=orange 	guifg=orange
highlight WhiteWhite    	guibg=white 	guifg=white
highlight RedRed 	    	guibg=red    	guifg=red
highlight BlackBlack   		guibg=black 	guifg=black
highlight GrayGray 	    	guibg=#303030 	guifg=#303030
highlight TabLineFill       guibg=#303030   guifg=#303030

let g:scrollbar_highlight = {
  \ 'head': 'Comment',
  \ 'body': 'Comment',
  \ 'tail': 'Comment',
  \ }

""source ~/.config/nvim/stuffs/minline.vim
let g:airline_theme='lucius'
