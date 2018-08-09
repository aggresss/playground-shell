#!/bin/bash

# toggle close the lid operation on and off

# linux shell color support.
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"

if [ $1 = 0 ];then
    # execute disable
    sudo sed -i 's/^HandleLidSwitch=ignore/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
    sudo sed -i 's/^HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=suspend/' /etc/systemd/logind.conf
    sudo systemctl restart systemd-logind
    ps -ef|grep 32221:127.0.0.1 |grep -v grep|awk '{print $2}'|xargs kill -9
    echo -e "${RED} Close the lattop lid will suspend. ${BLACK}"
fi

if [ $1 = 1 ];then
    # execute enable
    ps -ef|grep 32221:127.0.0.1 |grep -v grep|awk '{print $2}'|xargs kill -9
    sleep 1
    sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
    sudo sed -i 's/^#HandleLidSwitchDocked=ignore/HandleLidSwitchDocked=ignore/' /etc/systemd/logind.conf
    sudo sed -i 's/^HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
    sudo sed -i 's/^HandleLidSwitchDocked=suspend/HandleLidSwitchDocked=ignore/' /etc/systemd/logind.conf
    sudo systemctl restart systemd-logind
    autossh -M 32221 -fnN -R 32220:127.0.0.1:22 agg.vultr
    echo -e "${GREEN} Close the lattop lid will keep on working. ${BLACK}"
fi

