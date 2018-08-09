#!/bin/bash
#thinkapd t450 笔记本屏幕亮度调节
# max value 852

# linux shell color support.
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"

if [ $1 -ge 0 -a $1 -le 9 ]; then
	bv=$((($1+1)*85))
	#sudo chmod 777 /sys/class/backlight/intel_backlight/brightness
	echo $bv> /sys/class/backlight/intel_backlight/brightness
else
	echo -e "${RED} please input args from 0 to 9. ${BLACK}"
fi
#tlp-stat |grep "temp"
