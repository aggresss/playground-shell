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
NORMAL="\\033[m"

if [[ $(uname) = "Linux" ]]; then
    if [ -f /etc/apt/sources.list.origin ]; then
        sudo mv -f /etc/apt/sources.list.origin /etc/apt/sources.list
        echo -e "${YELLOW}Reset mirror file success${NORMAL}"
    else
        DISTRIBUTION=$(cat /etc/issue | awk '{print $1}')
        case ${DISTRIBUTION} in
            Ubuntu)
                sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.origin
                sudo sed -i 's/cn.archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list
                sudo sed -i 's/archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list
                echo -e "${GREEN}Alternate ubuntu mirror to aliyun${NORMAL}"
            ;;
            Debian)
                sudo cp -f /etc/apt/sources.list /etc/apt/sources.list.origin
                sudo sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
                echo -e "${GREEN}Alternate debian mirror to aliyun${NORMAL}"
            ;;
            *)
                echo -e "${RED}Not Support this operating system${NORMAL}"
            ;;
        esac
    fi
else
    echo -e "${RED}Not Support this operating system${NORMAL}"
fi

