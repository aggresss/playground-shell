#!/bin/bash

# toggle close the lid operation on and off
# initial run: sudo echo "#HandleLidSwitch=ignore" >> /etc/systemd/logind.conf

if [ $1 = 0 ];then
    # execute disable
    sudo sed -i 's/HandleLidSwitch=ignore/#HandleLidSwitch=ignore/' /etc/systemd/logind.conf
    sudo systemctl restart systemd-logind
    ps -ef|grep 32221:127.0.0.1 |grep -v grep|awk '{print $2}'|xargs kill -9
    echo -e "\e[31m Close the lattop lid will suspend. \e[0m"
fi

if [ $1 = 1 ];then
    # execute enable
    ps -ef|grep 32221:127.0.0.1 |grep -v grep|awk '{print $2}'|xargs kill -9
    sleep 1
    sudo sed -i 's/#HandleLidSwitch=ignore/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
    sudo systemctl restart systemd-logind
    autossh -M 32221 -fnN -R 32220:127.0.0.1:22 agg.vultr
    echo -e "\e[32m Close the lattop lid will keep on working. \e[0m"
fi

