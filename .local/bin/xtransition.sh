#!/bin/sh

# USAGE:
# `xtransition.sh X`
#	(where X is the 0-indexed desktop ID number as reported by xdotool)
# `xtransition.sh {right|left}`
#	with the direction to go towards by 1 workspace

oldws=$(xdotool get_desktop)
# newws=$1
tmpdir='/tmp/xtransition'
duration="0.5"

case $1 in
    [1-9])	newws=$1
		;;
    right)	_=$((newws=(oldws+1)))
		direction=right
		;;
    left)	_=$((newws=(oldws-1)))
		direction=left
		;;
esac

if [ "$oldws" -eq "$newws" ]; then
    exit
elif [ "$oldws" -lt "$newws" ]; then
    direction="left"
else
    direction="right"
fi

mkdir -p $tmpdir

# Screenshot of current workspace
scrot -o -F "${tmpdir}/${oldws}.jpg" &&
    # Switch to new workspace
    if ! [ -e "${tmpdir}/${newws}.jpg" ]; then
	xdotool set_desktop "${newws}" &&
	    # (the below number took a while to find,
	    # please don't change it without a good reason)
	    # sleep 0.0208354086434455 &&
	    sleep 0.03 && 
	    # Screenshot (on new workspace)
	    scrot -o -F "${tmpdir}/${newws}.jpg" #&&
	# Go back to old workspace
	xdotool set_desktop "${oldws}"
    fi

ffmpeg -y \
       -loop 1 -t "${duration}" -i "${tmpdir}/${oldws}.jpg" \
       -loop 1 -t "${duration}" -i "${tmpdir}/${newws}.jpg" \
       -filter_complex "[0][1]xfade=transition=slide${direction}:duration=${duration}" \
       -preset ultrafast \
       -deadline realtime \
       -f matroska - |
    mpv --no-terminal --fs -
# $tmpdir/output.mp4 &&
# mpv --no-terminal --fs $tmpdir/output.mp4 #&

xdotool set_desktop "${newws}"

# rm -rf $tmpdir
