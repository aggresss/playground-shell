#!/bin/bash
if [ $1 = 'v0' ]; then
	xrandr --output VGA1 --off
elif [ $1 = 'v1' ]; then
	xrandr --output VGA1 --left-of LVDS1 --auto
elif [ $1 = 'v2' ]; then
	xrandr --output VGA1 --right-of LVDS1 --auto
elif [ $1 = 'd0' ]; then
	xrandr --output DP1 --off
elif [ $1 = 'd1' ]; then
	xrandr --output DP1 --left-of LVDS1 --auto
elif [ $1 = 'd2' ]; then
	xrandr --output DP1 --right-of LVDS1 --auto
else
	echo -e "\e[31m please input args  v0,v1,v2  or  h0,h1,h2. \e[0m"
fi
#end
