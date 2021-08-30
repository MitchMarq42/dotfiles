" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8
let g:airline#themes#mitch#palette = {}
 let g:airline#themes#mitch#palette.normal = {
    \  'airline_a': [ '#000000' , '#b000b0' , 17  , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.insert = {
    \  'airline_a': [ '#000000' , '#009000' , 17  , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.visual = {
    \  'airline_a': [ '#000000' , '#ffaa00' , 17  , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.commandline = {
    \  'airline_a': [ '#000000' , '#ffffff' , 17  , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.terminal = {
    \  'airline_a': [ '#000000' , '#ffffff' , 17  , 190 , 'bold' ]
    \}

let g:airline#themes#mitch#palette.replace = copy(g:airline#themes#mitch#palette.insert)
let g:airline#themes#mitch#palette.accents = {
      \ 'red': [ '#000000' , '#ff0000' , 160 , ''  ]
      \ }
" Make my minline but make it airline
function! MinAirline(...)
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline_detect_modified=0
    let g:airline_inactive_collapse=1
    let g:airline_exclude_filetypes = ['man', 'help']
    let g:airline#extensions#disable_rtp_load = 1
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline_stl_path_style = 'short'
    let g:airline#extensions#keymap#enabled = 0
    let g:airline_section_a = airline#parts#mode()
    call a:1.add_section('MsgSeparator' , '%F')
    call a:1.add_section('RevStatLn'    , '%r%m')
    call a:1.add_section('GrayGray'     , '%=')
    call a:1.add_section('TabLineSel'   , '%y')
    call a:1.add_section('MsgSeparator' , '[%l:%-c]')
    call a:1.add_section('DiffChange'   , '[%p%%]')
    call a:1.add_section('DiffAdd'      , '%n')
    return 1
endfunction

call airline#add_statusline_func('MinAirline')
