#!/usr/bin/env bash

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

if [ "X_$1" = "X_" ]; then
    xrandr
elif [ $1 = 'v0' ]; then
    xrandr --output VGA1 --off
elif [ $1 = 'v1' ]; then
    xrandr --output VGA1 --left-of LVDS1 --auto
elif [ $1 = 'v2' ]; then
    xrandr --output VGA1 --right-of LVDS1 --auto
elif [ $1 = 'd0' ]; then
    xrandr --output DP1 --off --output LVDS1 --auto
elif [ $1 = 'd1' ]; then
    xrandr --output DP1 --left-of LVDS1 --auto
elif [ $1 = 'd2' ]; then
    xrandr --output DP1 --right-of LVDS1 --auto
else
    echo -e "${RED} please input args  v0,v1,v2  or  h0,h1,h2. ${BLACK}"
fi
#end
