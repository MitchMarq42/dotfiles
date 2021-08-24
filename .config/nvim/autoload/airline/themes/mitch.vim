" MIT License. Copyright (c) 2013-2021 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8

" Airline themes are generated based on the following concepts:
"   * The section of the status line, valid Airline statusline sections are:
"       * airline_a (left most section)
"       * airline_b (section just to the right of airline_a)
"       * airline_c (section just to the right of airline_b)
"       * airline_x (first section of the right most sections)
"       * airline_y (section just to the right of airline_x)
"       * airline_z (right most section)
"   * The mode of the buffer, as reported by the :mode() function.  Airline
"     converts the values reported by mode() to the following:
"       * normal
"       * insert
"       * replace
"       * visual
"       * inactive
"       * terminal
"       The last one is actually no real mode as returned by mode(), but used by
"       airline to style inactive statuslines (e.g. windows, where the cursor
"       currently does not reside in).
"   * In addition to each section and mode specified above, airline themes
"     can also specify overrides.  Overrides can be provided for the following
"     scenarios:
"       * 'modified'
"       * 'paste'
"
" Airline themes are specified as a global viml dictionary using the above
" sections, modes and overrides as keys to the dictionary.  The name of the
" dictionary is significant and should be specified as:
"   * g:airline#themes#<theme_name>#palette
" where <theme_name> is substituted for the name of the theme.vim file where the
" theme definition resides.  Airline themes should reside somewhere on the
" 'runtimepath' where it will be loaded at vim startup, for example:
"   * autoload/airline/themes/theme_name.vim
"
" For this, the mitch.vim, theme, this is defined as
let g:airline#themes#mitch#palette = {}
""    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 ],
""    \  'airline_c': [ '#ff0000' , '#303030' , 85  , 234 ],
""    \  'airline_x': [ '#9cffd3' , '#202020' , 85  , 234 ],
""    \  'airline_y': [ '#000000' , '#ffaa00' , 255 , 238 ],
""    \  'airline_z': [ '#ffffff' , '#0000ff' , 17  , 190 ]
""}

" Keys in the dictionary are composed of the mode, and if specified the
" override.  For example:
"   * g:airline#themes#mitch#palette.normal
"       * the colors for a statusline while in normal mode
"   * g:airline#themes#mitch#palette.normal_modified
"       * the colors for a statusline while in normal mode when the buffer has
"         been modified
"   * g:airline#themes#mitch#palette.visual
"       * the colors for a statusline while in visual mode
"
" Values for each dictionary key is an array of color values that should be
" familiar for colorscheme designers:
"   * [guifg, guibg, ctermfg, ctermbg, opts]
" See "help attr-list" for valid values for the "opt" value.
"
" Each theme must provide an array of such values for each airline section of
" the statusline (airline_a through airline_z).  A convenience function,
" airline#themes#generate_color_map() exists to mirror airline_a/b/c to
" airline_x/y/z, respectively.

" The mitch.vim theme:
 let g:airline#themes#mitch#palette.normal = {
    \  'airline_a': [ '#000000' , '#b000b0' , 17  , 190 , 'bold' ],
    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 , 'bold' ],
    \  'airline_c': [ '#000000' , '#ff0000' , 85  , 234 , 'bold' ],
    \  'airline_gutter': ['#303030' , '#303030' , 85 , 234 , 'bold' ],
    \  'airline_x': [ '#000000' , '#ffaa00' , 255 , 238 , 'bold' ],
    \  'airline_y': [ '#ffffff' , '#0000ff' , 17  , 190 , 'bold' ],
    \  'airline_z': [  '#000000' , '#009000' , 17 , 190 , 'bold' ],
    \  'airline_warning': [ '#000000' , '#b000b0' , 17 , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.insert = {
    \  'airline_a': [ '#000000' , '#009000' , 17  , 190 , 'bold' ],
    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 , 'bold' ],
    \  'airline_c': [ '#ff0000' , '#303030' , 85  , 234 , 'bold' ],
    \  'airline_x': [ '#000000' , '#ffaa00' , 255 , 238 , 'bold' ],
    \  'airline_y': [ '#ffffff' , '#0000ff' , 17  , 190 , 'bold' ],
    \  'airline_z': [  '#000000' , '#009000' , 17 , 190 , 'bold' ],
    \  'airline_warning': [ '#000000' , '#b000b0' , 17 , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.visual = {
    \  'airline_a': [ '#000000' , '#ffaa00' , 17  , 190 , 'bold' ],
    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 , 'bold' ],
    \  'airline_c': [ '#ff0000' , '#303030' , 85  , 234 , 'bold' ],
    \  'airline_x': [ '#000000' , '#ffaa00' , 255 , 238 , 'bold' ],
    \  'airline_y': [ '#ffffff' , '#0000ff' , 17  , 190 , 'bold' ],
    \  'airline_z': [  '#000000' , '#009000' , 17 , 190 , 'bold' ],
    \  'airline_warning': [ '#000000' , '#b000b0' , 17 , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.commandline = {
    \  'airline_a': [ '#000000' , '#ffffff' , 17  , 190 , 'bold' ],
    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 , 'bold' ],
    \  'airline_c': [ '#ff0000' , '#303030' , 85  , 234 , 'bold' ],
    \  'airline_x': [ '#000000' , '#ffaa00' , 255 , 238 , 'bold' ],
    \  'airline_y': [ '#ffffff' , '#0000ff' , 17  , 190 , 'bold' ],
    \  'airline_z': [  '#000000' , '#009000' , 17 , 190 , 'bold' ],
    \  'airline_warning': [ '#000000' , '#b000b0' , 17 , 190 , 'bold' ]
    \}
 let g:airline#themes#mitch#palette.terminal = {
    \  'airline_a': [ '#000000' , '#ffffff' , 17  , 190 , 'bold' ],
    \  'airline_b': [ '#ffffff' , '#0000ff' , 255 , 238 , 'bold' ],
    \  'airline_c': [ '#ff0000' , '#303030' , 85  , 234 , 'bold' ],
    \  'airline_x': [ '#000000' , '#ffaa00' , 255 , 238 , 'bold' ],
    \  'airline_y': [ '#ffffff' , '#0000ff' , 17  , 190 , 'bold' ],
    \  'airline_z': [  '#000000' , '#009000' , 17 , 190 , 'bold' ],
    \  'airline_warning': [ '#000000' , '#b000b0' , 17 , 190 , 'bold' ]
    \}
 ""let g:airline#themes#mitch#palette
"
" airline#themes#generate_color_map() also uses the values provided as
" parameters to create intermediary groups such as:
"   airline_a_to_airline_b
"   airline_b_to_airline_c
"   etc...

let g:airline#themes#mitch#palette.replace = copy(g:airline#themes#mitch#palette.insert)
""let g:airline#themes#mitch#palette.replace.airline_a = [ s:airline_b_insert[0]   , '#af0000' , s:airline_b_insert[2] , 124     , ''     ]
""let g:airline#themes#mitch#palette.replace_modified = g:airline#themes#mitch#palette.insert_modified

""let s:airline_a_visual = [ '#000000' , '#ffaf00' , 232 , 214 ]
""let s:airline_b_visual = [ '#000000' , '#ff5f00' , 232 , 202 ]
""let s:airline_c_visual = [ '#ffffff' , '#5f0000' , 15  , 52  ]
""let g:airline#themes#mitch#palette.visual_modified = {
""      \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 53      , ''     ] ,
""      \ }


let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:airline_c_inactive = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#mitch#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#mitch#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the 'readonly'
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let g:airline#themes#mitch#palette.accents = {
      \ 'red': [ '#000000' , '#ff0000' , 160 , ''  ]
      \ }
"" Actually define what stuff gets displayed...
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
let g:airline_section_b='%-0.25f'
let g:airline_section_c='%r%m'
""let g:airline_section_gutter='%=%=%t%='
let g:airline_section_x='%y'
let g:airline_section_y='[%l:%-c]'
let g:airline_section_z='[%p%%]'
let g:airline_section_warning='[%n]'
let g:airline_section_error=''
