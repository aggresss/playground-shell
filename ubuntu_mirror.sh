#!/bin/bash

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

mv /etc/apt/sources.list /etc/apt/source.list.bak
CODENAME=`cat /etc/lsb-release |sed -n '/CODENAME/p' |awk -F '=' '{print $2}'`
echo "\
deb http://mirrors.aliyun.com/ubuntu/ ${CODENAME} main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-backports main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-proposed main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-security main multiverse restricted universe
deb http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-updates main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ ${CODENAME} main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-backports main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-proposed main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-security main multiverse restricted universe
deb-src http://mirrors.aliyun.com/ubuntu/ ${CODENAME}-updates main multiverse restricted universe"> /etc/apt/sources.list
