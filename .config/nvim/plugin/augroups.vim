" go to previous location
augroup init
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END

" convert markdown to html
augroup markdown
    autocmd!
    " autocmd BufReadPost index.md call Indexify()
    autocmd BufWritePost *.md silent !markdown % > %:r.html
augroup END

" this is a test ofc <index pls>

" re-source any .vim files when you save them
augroup bufwritepost
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END

" scrollbar things (more in pluginstuff file)
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup end

" Indexify (for html)
"function Indexify() abort
    "normal gg
    "/\<index pls\>
    "for file in expand("!ls")
        "echon "[" . file . "]" . "(" . file . ")"
    "endfor
"endfunction

