#!/bin/sh

# USAGE:
# `xtransition.sh X`
#	(where X is the 0-indexed desktop ID number as reported by xdotool)
# `xtransition.sh {right|left}`
#	with the direction to go towards by 1 workspace

platform=$(
    case $(pgrep sway) in
	[0-9]*)
	    echo "sway" ;;
	"")
	    echo "Xorg" ;;
    esac
	)

oldws=$(
    case $platform in
	Xorg)
	    xdotool get_desktop
	    ;;
	sway)
	    swaymsg -pt get_workspaces |
		grep -i focused |
		sed -E 's_^.*([0-9]).*$_\1_'
	    ;;
    esac
     )

tmpdir='/tmp/xtransition'
duration="0.4"

screenshot(){
    case $platform in
	sway)
	    grim $@
	    ;;
	Xorg)
	    scrot -o -F $@
	    ;;
    esac
}
movews(){
    case $platform in
	sway)
	    swaymsg workspace $@
	    ;;
	Xorg)
	    xdotool set_desktop $@
    esac
}

case $1 in
    [0-9])
	newws=$1 ;;
    right)
	_=$((newws=(oldws+1)))
	direction=right ;;
    left)
	_=$((newws=(oldws-1)))
	direction=left ;;
    *)
	notify-send "化か"
	exit ;;
esac

if [ "$oldws" -lt "$newws" ]; then
    direction="left"
elif [ "$oldws" -gt "$newws" ]; then
    direction="right"
elif [ "$oldws" -eq "$newws" ]; then
    notify-send "化か"; exit
fi

# notify-send $direction

mkdir -p $tmpdir

# Screenshot of current workspace, for present and future use
screenshot "${tmpdir}/${oldws}.png"

if ! [ -e "${tmpdir}/${newws}.png" ]; then
    # Switch to new workspace
    movews "${newws}" &&
	# (the below number took a while to find,
	# please don't change it without a good reason)
	# sleep 0.0208354086434455 &&
	sleep 0.03 && 
	# Screenshot (on new workspace)
	screenshot "${tmpdir}/${newws}.png" #&&
    # Go back to old workspace
    movews "${oldws}"
fi

ffmpeg -y \
       -loop 1 -t "${duration}" -i "${tmpdir}/${oldws}.png" \
       -loop 1 -t "${duration}" -i "${tmpdir}/${newws}.png" \
       -filter_complex "[0][1]xfade=transition=slide${direction}:duration=${duration}" \
       -c:v libx265 \
       -preset ultrafast \
       -crf 18 \
       -deadline realtime \
       -f matroska - |
    mpv --no-terminal --fs -
# $tmpdir/output.mp4 &&
# mpv --no-terminal --fs $tmpdir/output.mp4 #&
       # -vaapi_device /dev/dri/renderD128 \
       # -vcodec h264_vaapi \



movews "${newws}"

# rm -rf $tmpdir
