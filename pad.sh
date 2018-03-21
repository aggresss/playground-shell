#!/bin/bash
# toggle touchpad on and off

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

