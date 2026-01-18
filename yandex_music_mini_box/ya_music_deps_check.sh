#!/bin/sh
#script for "Yandex Music". checks:

MISSING=""

check_missing(){
    command -v "$1" >/dev/null 2>&1 || MISSING="$MISSING $1"
}

check_missing wmctrl
check_missing xdotool
check_missing notify-send

if [ -n "$MISSING" ]; then
    echo "MISSING dependencies:$MISSING"

    echo "Install missing dependencies? [y/N]"
    read answer
    case "$answer" in
        y|Y)
            ./ya_music_deps_install.sh || {
                echo "Installation failed."
                exit 1
            }
            ;;
        *)
            echo "Close script"
            exit 1
            ;;
    esac
    exit 1
fi

#`sh ya_music_deps_check.sh` = Run script(terminal)
#'echo $?' (need 0 for complite)