" convert markdown to html
augroup markdown
    autocmd!
    autocmd BufWritePost *.md silent !markdown % > %:r.html
augroup END

" re-source any .vim files when you save them
augroup bufwritepost
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END

" go to previous location
autocmd BufReadPost * silent! normal! g`"zv

" scrollbar things (more in pluginstuff file)
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup end
