#!/bin/sh

##скрипт для выбора монитора

STATE_FILE="$HOME/.monitor_state"

LAPTOP="LVDS-1"
HDMI="HDMI-1"

#для фикса бага с свъездом раздельного экрана
WALLPAPERHDMI="/home/Igor227/Изображения/DisplayImage2HDMI.png"
WALLPAPERLAPTOP="/home/Igor227/scripts/My-scripts-for-antiX-23.2_x64-full-linux/Display_Image/LAPTOP_PAINT.png"

set_wallpaper_2_display(){
    xwallpaper --output "$LAPTOP" --stretch "$WALLPAPERLAPTOP" \
           --output "$HDMI" --stretch "$WALLPAPERHDMI"
}

# если файла состояния нет — создаём
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"

STATE=$(cat "$STATE_FILE")

#xrandr -fb 1366x768 #костыль, через пару циклов можно сетнуть

# если HDMI не подключён — всегда ноутбук
if ! xrandr | grep -q "$HDMI connected"; then
    xrandr --output "$HDMI" --off --output "$LAPTOP" --auto --primary
    echo 0 > "$STATE_FILE"
    xwallpaper --output "$LAPTOP" --stretch "$WALLPAPERLAPTOP"
    exit 0
fi

xrandr --output "$HDMI" --off \
       --output "$LAPTOP" --off

case "$STATE" in
    0)
        # только HDMI
        xrandr --output "$HDMI" --auto --primary \
               --output "$LAPTOP" --off
        echo 1 > "$STATE_FILE"
        xwallpaper --output "$HDMI" --stretch "$WALLPAPERHDMI"
        ;;
    1)
        # оба, HDMI слева
        xrandr --output "$HDMI" --auto --left-of "$LAPTOP" --primary \
               --output "$LAPTOP" --auto 
        echo 2 > "$STATE_FILE"
        set_wallpaper_2_display
        ;;
    2)
        # оба, HDMI справа
        xrandr --output "$HDMI" --auto --right-of "$LAPTOP" --primary \
               --output "$LAPTOP" --auto 
        echo 0 > "$STATE_FILE"
        set_wallpaper_2_display
        ;;
esac
