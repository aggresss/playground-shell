#!/bin/bash
# Change default runlevel on Debian systemd based system

if [ "X_$1" = "X_" ]; then
    runlevel
elif [ $1 -ge 0 -a $1 -le 6 ]; then
    sudo ln -sf /lib/systemd/system/runlevel$1.target /etc/systemd/system/default.target
else
    echo -e "\e[31m please input args 0-6 \e[0m"
fi
#end
