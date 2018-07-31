#!/usr/bin/expect

set ip [lindex $argv 0]
set username [lindex $argv 1]
set passwd [lindex $argv 2]

spawn telnet $ip
expect "IPNC login:" {send "$username\r"}
expect "Password:" {send "$passwd\r"}
interact
