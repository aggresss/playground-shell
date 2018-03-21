#!/bin/bash
# random mac address

mac=`od /dev/urandom -w6 -tx1 -An|sed -e 's/ //' -e 's/ /:/g'|head -n 1`
sudo ifconfig eth0 down
sudo ifconfig eth0 hw ether ${mac}
sleep 5
sudo ifconfig eth0 up
