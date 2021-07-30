"""" Set a custom Status Line because the default one is bland """"

""""" Set tabline to kinda match statusline cause I'm addicted to this now
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
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999X[X]'
	endif

	return s
endfunction

function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return bufname(buflist[winnr - 1])
endfunction

set showtabline=1
set tabline=%!MyTabLine()

"set statusline=
"set statusline+=%#MsgSeparator# " bold, white on blue
"set statusline+=%f\           	" file name
"set statusline+=%#DiffDelete#   " bold, black on red
"set statusline+=%r  		    " for read-only
"set statusline+=%m  	       	" modified [+] flag
"set statusline+=%#TabLineFill#  " gray on gray
"set statusline+=%=	        	" right align
"set statusline+=%#DiffText#     " bold, black on orange
"set statusline+=%y   	    	" file type
"set statusline+=%#MsgSeparator# " bold, white on blue
"set statusline+=[%l:%-c]     	" line + column
"set statusline+=%#DiffChange#   " bold black on green
"set statusline+=[%p%%]  	   	" percentage
"set statusline+=%#DiffAdd#  	" bold, black on purple
"set statusline+=[%n]	    	" buffer number
