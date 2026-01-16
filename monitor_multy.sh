#!/bin/sh

##скрипт для выбора монитора

STATE_FILE="$HOME/.monitor_state"

LAPTOP="LVDS-1"
HDMI="HDMI-1"

#для фикса бага с свъездом раздельного экрана
WALLPAPERHDMI="/home/Igor227/Изображения/HDMI_PAINT.png"
WALLPAPERLAPTOP="/home/Igor227/Изображения/LAPTOP_PAINT.png"

set_wallpaper_2_display(){
    xwallpaper --output "$LAPTOP" --stretch "$WALLPAPERLAPTOP" \
           --output "$HDMI" --stretch "$WALLPAPERHDMI"
}


# если файла состояния нет — создаём
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"

STATE=$(cat "$STATE_FILE")

# если HDMI не подключён — всегда ноутбук
if ! xrandr | grep -q "$HDMI connected"; then
    xrandr --output "$HDMI" --off --output "$LAPTOP" --auto --primary
    echo 0 > "$STATE_FILE"
    xwallpaper --output "$LAPTOP" --stretch "$WALLPAPERLAPTOP"
    exit 0
fi

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
        xrandr --output "$HDMI" --auto --left-of "$LAPTOP" \
               --output "$LAPTOP" --auto --primary
        echo 2 > "$STATE_FILE"
        set_wallpaper_2_display
        ;;
    2)
        # оба, HDMI справа
        xrandr --output "$HDMI" --auto --right-of "$LAPTOP" \
               --output "$LAPTOP" --auto --primary
        echo 0 > "$STATE_FILE"
        set_wallpaper_2_display
        ;;
esac
