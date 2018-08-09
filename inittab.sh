#!/bin/bash
# Change default runlevel on Debian systemd based system

# linux shell color support.
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"

if [ "X_$1" = "X_" ]; then
    runlevel
elif [ $1 -ge 0 -a $1 -le 6 ]; then
    sudo ln -sf /lib/systemd/system/runlevel$1.target /etc/systemd/system/default.target
else
    echo -e "${RED} please input args 0-6 ${BLACK}"
fi
#end
