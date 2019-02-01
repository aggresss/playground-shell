#!/usr/bin/env bash
#thinkapd 笔记本屏幕亮度调节
# max value 852

# linux shell color support.
BLACK="\\033[30m"
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLUE="\\033[34m"
MAGENTA="\\033[35m"
CYAN="\\033[36m"
WHITE="\\033[37m"
NORMAL="\\033[0m"
HIGHLIGHT="\\033[1m"
INVERT="\\033[7m"

backlight_path="/sys/class/backlight/intel_backlight"

if [ -f ${backlight_path}/max_brightness ]; then
    max_value=$(cat ${backlight_path}/max_brightness)
    # echo $max_value
else
    echo -e "${RED}NO SUPPORT ON THIS PLATFORM.${NORMAL}"
    exit 1
fi

if [ $1 -ge 0 -a $1 -le 10 ]; then
    bv=$(($max_value/10*$1))
    if [ $bv -eq 0 ]; then
        bv=$(($max_value/30))
    fi
    # echo $bv
	sudo chmod 777 ${backlight_path}/brightness
	echo $bv> ${backlight_path}/brightness
else
	echo -e "${RED} please input args from 0 to 10. ${NORMAL}"
fi
#tlp-stat |grep "temp"

