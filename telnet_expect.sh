#!/usr/bin/expect

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
LIGHT="\\033[1m"
INVERT="\\033[7m"


set ip [lindex $argv 0]
set username [lindex $argv 1]
set passwd [lindex $argv 2]

spawn telnet $ip
expect "IPNC login:" {send "$username\r"}
expect "Password:" {send "$passwd\r"}
interact
