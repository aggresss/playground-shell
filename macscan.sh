#!/usr/bin/env bash
# scan mac address in the local area network
# $1 for network address

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

target="10.2.0.0/22"
if [ "X_$1" != "X_" ];then
    target=$1
fi
sudo nmap -sP -PI -PT ${target} |sed -r '/^Nmap/b2; d; b3; :2; N; N; s/\n/ /g; :3;' |sed 's/^Nmap scan report for \(.*\)/\1/'
