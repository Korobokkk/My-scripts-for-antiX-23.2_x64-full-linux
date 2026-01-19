#!/bin/sh
#script for "Yandex Music". checks:

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

check_all_missing(){
    MISSING=""
    
    check_missing(){
        command -v "$1" >/dev/null 2>&1 || MISSING="$MISSING $1"
    }

    check_missing wmctrl
    check_missing xdotool
    check_missing notify-send
    #check_missing test_deps #FOR CHECKS
}

check_all_missing
if [ -n "$MISSING" ]; then
    echo "${YELLOW}MISSING dependencies:$MISSING ${RESET}"
    echo "${YELLOW}Install missing dependencies? [y/N]${RESET}"
    read answer
    case "$answer" in
        y|Y)
            ./ya_music_deps_install.sh || {
                echo "${RED}ERROR 3: Installation failed.${RESET}"
                exit 1
            }

            check_all_missing
            if [ -n "$MISSING" ]; then
                echo "${RED}ERROR 4:can't fix problem with $MISSING ${RESET}"
                echo "${YELLOW}RECOMMENDATION: Manual installation of these dependencies is recommended.${RESET}"
                exit 1
            fi
            ;;
        *)
            echo "${YELLOW}WARING:You canceled the installation.${RESET}"
            exit 1
            ;;
    esac
fi

exit 0

#`sh ya_music_deps_check.sh` = Run script(terminal)
#'echo $?' (need 0 for complite)