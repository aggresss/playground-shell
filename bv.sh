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

if [ "x$1" = "x" ]; then
    bv=$(cat ${backlight_path}/brightness)
    max_bv=$(cat ${backlight_path}/max_brightness)
    echo -e "${HIGHLIGHT}${GREEN}$((${bv}*100/${max_bv}))/100${NORMAL}"
    exit 0
fi

if [ $1 -ge 1 -a $1 -le 100 ]; then
    bv=$(($max_value/100*$1))
    # echo $bv
	sudo chmod 777 ${backlight_path}/brightness
	echo $bv> ${backlight_path}/brightness
else
	echo -e "${HIGHLIGHT}${RED} Please input args from 1 to 100. ${NORMAL}"
fi
#tlp-stat |grep "temp"

