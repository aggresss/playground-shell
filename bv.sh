#!/bin/bash
#thinkapd t450 笔记本屏幕亮度调节
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
NORMAL="\\033[m"

if [ $1 -ge 0 -a $1 -le 9 ]; then
	bv=$((($1+1)*85))
	#sudo chmod 777 /sys/class/backlight/intel_backlight/brightness
	echo $bv> /sys/class/backlight/intel_backlight/brightness
else
	echo -e "${RED} please input args from 0 to 9. ${BLACK}"
fi
#tlp-stat |grep "temp"
