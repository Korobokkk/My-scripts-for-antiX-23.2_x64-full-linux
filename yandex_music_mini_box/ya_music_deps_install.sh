#!/bin/sh

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"


echo "${BLUE}Hi. This is Yandex music dependenscy installer${RESET}"

if [ "$EUID" -eq 0 ]; then #check user|root 
    SUDO=""
else
    SUDO="sudo"
fi

echo "${BLUE}INSTALL||UPDATE wmctrl, xdotool, libnotify-bin${RESET}"
$SUDO apt install wmctrl xdotool libnotify-bin #test_sdeps FOR CHECKS

echo "${GREEN}The installation is complete. If there are any issues with the deps, you will see them in the deps_check script${RESET}"
echo "${YELLOW}Link to the official Yandex Music client: https://music.yandex.ru/download/${RESET}"
echo "${YELLOW}Download this client or any other client that has 'музыка'|| 'music' in its name and Run:${RESET} ${GREEN}/.ya_music_mini_box.sh${RESET}"

exit 0