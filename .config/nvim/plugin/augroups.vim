" go to previous location
augroup resume
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END

" convert markdown to html
augroup markdown
    autocmd!
    autocmd BufWritePost *.md silent !markdown % > %:r.html
augroup END

" re-source any .vim files when you save them
augroup vimrc
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END

" scrollbar things (more in pluginstuff file)
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained	       * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost		* silent! lua require('scrollbar').clear()
augroup END

" Packer, for plugins.
augroup packer_user_config
  autocmd!
  autocmd BufWritePost pluginstuff.lua source <afile> | PackerCompile
augroup end

" *.gsets files. I made this up because dconf is oof.
augroup dconf
    autocmd!
    autocmd BufReadPre *.gsets silent !dconf dump /org/gnome/%:t:r/ > %
    autocmd BufReadPost *.gsets set ft=dosini
    autocmd BufWritePost *.gsets silent !cat % | dconf load /org/gnome/%:t:r/
augroup END
