
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
:
" To insert a  do <C-v>u e0b0
" to insert a  do <C-v>u e0b2

set statusline=
"set statusline+=%{%GetHiArrow('blue','black')%}
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
