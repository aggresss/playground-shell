#!/bin/bash
# scan mac address in the local area network
# $1 for network address
target="10.2.0.0/22"
if [ "X_$1" != "X_" ];then
    target=$1
fi
sudo nmap -sP -PI -PT ${target} |sed -r '/^Nmap/b2; d; b3; :2; N; N; s/\n/ /g; :3;' |sed 's/^Nmap scan report for \(.*\)/\1/'
