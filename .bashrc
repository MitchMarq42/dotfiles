[ -z "${ZSH}" ] && export ZSH=$(find -O3 ~/.local -type l -user $USER -executable -name zsh 2>/dev/null | grep "bin" )
exec $ZSH
