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
set background=dark
set termguicolors
"highlight Background        guibg=black                                 ctermbg=0
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
highlight Normal	    	guibg=#000000	guifg=#cccc66	gui=none	ctermbg=0   ctermfg=11          cterm=none
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
highlight TabLineFill   	guibg=#303030 	guifg=#303030
highlight TabLine 	    	guibg=green 	guifg=black
highlight GreenGreen    	guibg=green 	guifg=green
highlight PurplePurple  	guibg=purple 	guifg=purple
highlight OrangeOrange  	guibg=orange 	guifg=orange
highlight WhiteWhite    	guibg=white 	guifg=white
highlight RedRed 	    	guibg=red    	guifg=red
highlight BlackBlack   		guibg=black 	guifg=black
highlight GrayGray 	    	guibg=#303030 	guifg=#303030

highlight BluBG             guibg=blue      guifg=fg
highlight RedBG             guibg=red       guifg=fg
highlight GrayBG            guibg=#303030   guifg=fg
highlight OrangeBG          guibg=orange    guifg=fg
highlight GreenBG           guibg=green     guifg=fg
highlight PurpleBG          guibg=purple    guifg=fg

highlight WhiteFG           guibg=bg        guifg=white     gui=bold
highlight BlackFG           guibg=bg        guifg=black     gui=bold
highlight NoBoldBG          guibg=bg        guifg=fg        gui=none

let g:scrollbar_highlight = {
  \ 'head': 'Comment',
  \ 'body': 'Comment',
  \ 'tail': 'Comment',
  \ }

function! ArrowColor(fg,bg)
    let highlightstr = 'highlight Arrow' . a:fg . a:bg . ' '
    let highlightstr .= 'guifg=' . a:fg . ' '
    let highlightstr .= 'guibg=' . a:bg

    execute highlightstr
endfunction

"""" Set a custom Status Line because the default one is bland """"
highlight statusline guifg=black guibg=black
highlight statuslineNC guifg=black guibg=black

function! GetHiArrow(fg,bg)
    if a:fg == "gray"
        let l:fgn="#303030"
    else
        let l:fgn=a:fg
    endif
    if a:bg == "gray"
        let l:bgn="#303030"
    else
        let l:bgn=a:bg
    endif
    exec "highlight " . "arrow" . a:fg . a:bg . " " . "guifg=" . l:fgn . " guibg=" . l:bgn
    let l:stlarrowstr = "%#arrow" . a:fg . a:bg . "#"
    return l:stlarrowstr
endfunction

" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={ 'n' : 'Normal', 'no' : 'N·Operator Pending', 'v' : 'Visual', 'V' : 'V·Line', '^V' : 'VBlock', 's' : 'Select', 'S': 'S·Line', '^S' : 'S·Block', 'i' : 'Insert', 'R' : 'Replace', 'Rv' : 'V·Replace', 'c' : 'Command', 'cv' : 'Vim Ex', 'ce' : 'Ex', 'r' : 'Prompt', 'rm' : 'More', 'r?' : 'Confirm', '!' : 'Shell', 't' : 'Terminal'}

" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'VBlock'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'VBlock'))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction
set noshowmode

" To insert a  do <C-v>u e0b0
" to insert a  do <C-v>u e0b2

set statusline=
set statusline+=%{%GetHiArrow('blue','black')%}
set statusline+=%#cString#[%{ModeCurrent()}]

set statusline+=%{%GetHiArrow('black','blue')%}
set statusline+=%#MsgSeparator#%f
set statusline+=%{%GetHiArrow('blue','red')%}
set statusline+=%#DiffDelete#%r%m
set statusline+=%{%GetHiArrow('red','gray')%}
set statusline+=%#GrayGray#%=%=%=%t%=
set statusline+=%{%GetHiArrow('orange','gray')%}
set statusline+=%#TabLineSel#%y
set statusline+=%{%GetHiArrow('blue','orange')%}
set statusline+=%#MsgSeparator#[%l:%-c]
set statusline+=%{%GetHiArrow('green','blue')%}
set statusline+=%#DiffChange#[%p%%]
set statusline+=%{%GetHiArrow('purple','green')%}
set statusline+=%#DiffAdd#[%n]
set statusline+=%{%GetHiArrow('black','purple')%}
