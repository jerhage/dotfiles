##!/bin/sh
#
#[ -d "$1" ] || {
#  echo "Usage: $0 DIRECTORY" >&2
#  exit 1
#}
#
#RESIZE_TYPE=fit
#export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-60}"
#export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"
#
#img=$(
#  fd --type f \
#     -e jpg -e jpeg -e png -e webp \
#     --search-path "$1" \
#  | awk 'BEGIN{srand()} {f[NR]=$0} END{print f[int(rand()*NR)+1]}'
#)
#
#[ -n "$img" ] || exit 1
#
#awww img --resize="$RESIZE_TYPE" "$img"
#!/bin/sh

DEFAULT_WALLDIR="$HOME/wallpapers"
RESIZE_TYPE=fit

export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-60}"
export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"

usage() {
	cat <<EOF
Usage: $(basename "$0") [DIRECTORY]

Sets a random wallpaper using awww.

If DIRECTORY is not provided, defaults to:
  $DEFAULT_WALLDIR

Options:
  -h, --help    Show this help and exit
EOF
}

case "$1" in
	-h|--help)
		usage
		exit 0
	;;
	"")
		WALLDIR="$DEFAULT_WALLDIR"
	;;
	*)
		WALLDIR="$1"
	;;
esac

[ -d "$WALLDIR" ] || {
	echo "error: '$WALLDIR' is not a directory" >&2
	exit 1
}

img=$(
  fd --type f \
     -e jpg -e jpeg -e png -e webp \
     --search-path "$WALLDIR" \
  | awk 'BEGIN{srand()} {f[NR]=$0} END{print f[int(rand()*NR)+1]}'
)

[ -n "$img" ] || exit 1

awww img --resize="$RESIZE_TYPE" "$img"
