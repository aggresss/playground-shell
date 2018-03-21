#!/bin/bash
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
