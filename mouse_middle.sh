#!/usr/bin/env bash
# mouse middle button paste function on/off

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
LIGHT="\\033[1m"
INVERT="\\033[7m"

if [ $1 = 0 ];then
    # execute disable
    xmodmap -e "pointer = 1 25 3 4 5 6 7 2 9 10"
fi

if [ $1 = 1 ];then
    # execute enable
    xmodmap -e "pointer = 1 2 3 4 5 6 7 8 9 10"
fi


