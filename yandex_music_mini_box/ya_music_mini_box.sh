#!/bin/sh
HOTKEY_MODE=0 # for --hotkey mode
for arg in "$@"; do
    case "$arg" in 
        --hotkey)
        HOTKEY_MODE=1
        ;;
    esac
done

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

#fix problem with icewm/keys
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/ya_music_deps_check.sh" "$HOTKEY_MODE" || exit 1

if [ -z "$DISPLAY" ]; then
    echo "${RED}Error 1: no session detected(X11)${RESET}"
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
    echo "${RED}Error 2: Ya_music not open${RESET}}"
    exit 0
fi
wmctrl -i -r "$WIN_ID" -e "0,0,0,500,350"
wmctrl -i -R "$WIN_ID"

echo "${GREEN}Very good${RESET}"