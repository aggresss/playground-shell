#!/bin/bash
# toggle touchpad on and off

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

# capture the Touchpad input id
id=`xinput |grep TouchPad |awk -F= '{print $2}' |awk '{print $1}'`

if [ $1 = 0 ];then
    # execute disable
    xinput disable $id
fi

if [ $1 = 1 ];then
    # execute enable
    xinput enable $id
fi

