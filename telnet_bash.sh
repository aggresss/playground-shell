#!/usr/bin/env bash

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
HIGHLIGHT="\\033[1m"
INVERT="\\033[7m"

ip=$1
username=$2
passwd=$3

expect -c "
    spawn telnet $ip
    expect {
        \"IPNC login:\" {send \"$username\r\";exp_continue}
        \"Password:\" {send \"$passwd\r\";interact}
    }
"

