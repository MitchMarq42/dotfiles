" For ext_win mini-plugin
let g:ext_win = "nvim-qt"
function! NewWindow(arg)
    let g:open_extterm = "silent !" . g:ext_win . " " . a:arg . "&"
    execute g:open_extterm
endfunction

augroup newwin
    autocmd!
    autocmd QuitPre * nnoremap ZZ :w <bar> :close
    autocmd QuitPre * nnoremap ZQ :silent! close
augroup END

command! -nargs=1 Newwin call NewWindow("<args>")
