#!/bin/sh
#

./ya_music_deps_check.sh || exit 1

if [ -z "$DISPLAY" ]; then
    echo "Error 1: no session detected(X11)"
    exit 1
fi

find_music_window() {
    wmctrl -l \
    | grep -Ei 'yandex|music|яндекс|музыка' \
    | grep -Ev '\.sh|code' \
    | awk '{print $1}' \
    | head -n1
}

WIN_ID=$(find_music_window)
if [ -z "$WIN_ID" ]; then
    echo "Error 3: Ya_music not open"
    exit 0
fi
wmctrl -i -r "$WIN_ID" -e "0,0,0,500,350"
wmctrl -i -R "$WIN_ID"

echo " Very good"