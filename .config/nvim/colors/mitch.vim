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

" hi	  thing		    	guibg	    	guifg	       	gui
hi clear
"set background=dark
set termguicolors
highlight Normal	    	guibg=#000000	guifg=#eeee99	gui=none
highlight Comment  	    	guibg=none    	guifg=#00aa00   gui=none
highlight NonText 	    	guibg=none      guifg=brown     gui=bold
highlight Constant          guibg=none  	guifg=#0077ff	gui=none
highlight cString 	    	guibg=none      guifg=white 	gui=bold
highlight cCppString    	guibg=none  	guifg=white 	gui=bold
highlight cBracket 	    	guibg=red   	guifg=#cccc66   gui=bold
highlight Identifier    	guibg=none  	guifg=#00c0c0	gui=none
highlight Statement	    	guibg=none      guifg=#c0c000	gui=bold
highlight PreProc  	    	guibg=none      guifg=#0088ff	gui=bold
highlight Type		    	guibg=none      guifg=orange	gui=bold
highlight Special       	guibg=none      guifg=#bb00bb	gui=bold
highlight Error		    	guibg=#ff0000   guifg=white		gui=none
highlight Todo		    	guibg=#c0c000	guifg=#000080	gui=none
highlight Directory	    	guibg=none	    guifg=#00c000	gui=bold
highlight Search	    	guibg=purple 	guifg=yellow    gui=none
highlight operator 	    	guibg=none   	guifg=pink      gui=none
highlight statement	    	guibg=none      guifg=red	    gui=bold
highlight DiffAdd 	    	guibg=purple 	guifg=black	    gui=bold
highlight DiffChange    	guibg=green 	guifg=black	    gui=bold
highlight DiffDelete    	guibg=red    	guifg=black	    gui=bold
highlight DiffText 	    	guibg=orange 	guifg=black	    gui=bold
highlight MsgSeparator  	guibg=blue  	guifg=white	    gui=bold
highlight CursorLine    	guibg=#303030
highlight CursorColumn  	guibg=#303030
highlight VertSplit     	guibg=none   	guifg=purple	gui=bold
highlight RevComment    	guibg=green 	guifg=black 	gui=none
highlight RevStatLn     	guibg=red   	guifg=black	    gui=bold
highlight CmdMode 	    	guibg=white 	guifg=black	    gui=bold
highlight TabLineSel    	guibg=orange 	guifg=black	    gui=bold
highlight LineNr            guibg=none      guifg=yellow    gui=none
highlight CursorLineNr      guibg=black     guifg=yellow    gui=bold
"highlight StatusLine        guibg=blue      guifg=white     gui=bold
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

" source ~/.config/nvim/stuffs/minline.vim
" let g:airline_theme='lucius'

hi Trailing guifg=green guibg=red
match Trailing /\s\+$/ 
