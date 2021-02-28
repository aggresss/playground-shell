#!/usr/bin/env bash

# fast decompression archives
function un_ball()
{
    if [ $# -ne 1 ]; then
        echo -e "${RED}Arguments no support.${NORMAL}"
        return 1;
    fi
    if [[ $1 =~ .*\.zip$ ]]; then
        # *.zip
        unzip $1 -d ${1%.zip}
    elif [[ $1 =~ .*\.rar$ ]]; then
        # *.rar
        mkdir -p ${1%.rar}
        unrar x $1 ${1%.rar}
    elif [[ $1 =~ .*\.7z$ ]]; then
        # *.7z
        7z x $1
    elif [[ $1 =~ .*\.tar.xz$ ]]; then
        # *.tar.xz
        tar Jvxf $1
    elif [[ $1 =~ .*\.tar.gz$ || $1 =~ .*\.tgz$ ]]; then
        # *.tar.gz or *.tgz
        tar zvxf $1
    elif [[ $1 =~ .*\.tar.bz2$ ]]; then
        # *.tar.bz2
        tar jvxf $1
    elif [[ $1 =~ .*\.tar$ ]]; then
        # *.tar
        tar vxf $1
    else
        echo -e "${RED}Archive tpye no support.${NORMAL}"
    fi
}

un_ball $@
