"""" Set a custom Status Line because the default one is bland """"
set statusline=
set statusline+=%#ArrowBlackPurple#
set statusline+=%{(mode()=='n')?'':''}
set statusline+=%#ArrowBlackGreen#%{(mode()=='i')?'':''}
set statusline+=%#ArrowBlackRed#%{(mode()=='R')?'':''}
set statusline+=%#ArrowBlackOrange#%{(mode()=='v')?'':''}
set statusline+=%#ArrowBlackOrange#%{(mode()=='V')?'':''}
set statusline+=%#ArrowBlackWhite#%{(mode()=='c')?'':''}
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ [NORMAL]':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ [INSERT]':''}
set statusline+=%#DiffDelete#%{(mode()=='R')?'\ [RPLACE]':''}
set statusline+=%#DiffText#%{(mode()=='v')?'\ [VISUAL]':''}
set statusline+=%#DiffText#%{(mode()=='V')?'\ [VIS\ LN]':''}
set statusline+=%#CmdMode#%{(mode()=='c')?'\ [COMMAND]':''}
set statusline+=%#ArrowPurpleRed#%{(mode()=='n')?'':''}
set statusline+=%#ArrowGreenRed#%{(mode()=='i')?'':''}
set statusline+=%#ArrowRedRed#%{(mode()=='R')?'':''}
set statusline+=%#ArrowOrangeRed#%{(mode()=='v')?'':''}
set statusline+=%#ArrowOrangeRed#%{(mode()=='V')?'':''}
set statusline+=%#ArrowWhiteRed#%{(mode()=='c')?'':''}
set statusline+=%#RevStatLn#	" color for below
set statusline+=%r		        " for read-only
set statusline+=%m	        	" modified [+] flag
set statusline+=%#ArrowRedBlue# " color for below:
set statusline+=	        	" arrow thingy
set statusline+=%#MsgSeparator#	" color for below:
set statusline+=%f          	" file name
set statusline+=%#ArrowBlueGray# " color for below:
set statusline+=	        	" arrow thingy
set statusline+=%#GrayGray#	    " color for below:
set statusline+=%=	        	" right align
set statusline+=%#ArrowGrayBlue# " color for below:
set statusline+=	          	" arrow thingy
set statusline+=%#MsgSeparator#	" color for below:
set statusline+=[%p%%]		" percentage
set statusline+=%#ArrowBlueGreen# " color for below:
set statusline+=		" arrow thingy
set statusline+=%#DiffChange#	" color for below:
set statusline+=[%Y]		" file type
set statusline+=%#ArrowGreenOrange#	" color for below:
set statusline+=		" arrow thingy
set statusline+=%#DiffText#	" color for below:
set statusline+=[%l:%-c]	" line + column
set statusline+=%#ArrowOrangePurple# " color for below:
set statusline+=		" arrow thingy
set statusline+=%#DiffAdd#	" color for below:
set statusline+=[%n]		" buffer number
set statusline+=%#ArrowPurpleBlack# "color for below:
set statusline+=		" arrow thingy
set noshowmode
"""" Set tabline to kinda match statusline cause I'm addicted to this now
function MyTabLine()
	let s = '%#ArrowGreenBlack#'
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()			" Current tab
			let s .= '%#ArrowBlackOrange#'
			let s .= ''
			let s .= '%#TabLineSel#'
			let s .= '%' . (i + 1) . 't'
			"let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
			let s .= '%#ArrowOrangeBlack#'
			let s .= ''
		else					" every other tab
			let s .= '%#ArrowBlackGreen#'
			let s .= ''
			let s .= '%#TabLine#'
            "let s .= '%t'
			let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
			let s .= '%' . (i + 1) . 'T'
			let s .= '%#ArrowGreenBlack#'
			let s .= ''
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		"let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	let s .= '%#ArrowBlackGray#'
	let s .= ''

	" right-align the label to close the current tab page
	"if tabpagenr('$') > 1
		"let s .= '%=%#TabLine#%999X[X]'
	"endif

	return s
endfunction

function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return bufname(buflist[winnr - 1])
endfunction

set showtabline=1
set tabline=%!MyTabLine()
