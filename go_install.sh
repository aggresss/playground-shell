#!/bin/bash
# environment file for install golang package
set -uv

# viriable for install
BASE_URL_1="http://repo.router7.com/go"
BASE_URL_2="https://dl.google.com/go"

if [ ${1-NoDefine} = "NoDefine" ]; then
    GO_VERSION="1.10.5"
else
    GO_VERSION="$1"
fi

###  function for download and extract to assign path ####
# $1 download URL
# $2 local path
function down_load
{
    local down_file=`echo "$1" | awk -F "/" '{print $NF}'`
    local file_ext=${down_file##*.}
    if [ $(curl -I -o /dev/null -s -w %{http_code} $1) != 200 ]; then
        echo "Query $1 not exist."
        return 1
    fi
    if ! curl -OL $1; then
        echo "Download $1 failed."
        return 2
    fi
    if [ ! -d $2 ]; then
        mkdir -p $2
    fi
    if [ $file_ext = "gz" -o $file_ext = "bz2" ]; then
        tar -vxf ${down_file} -C $2 --strip-components 1
        rm -rf ${down_file}
    fi
}

if [ $(uname -m) = "x86_64" ]; then
    case $(uname) in
    Darwin)
        down_load ${BASE_URL_1}/go${GO_VERSION}.darwin-amd64.tar.gz ${HOME}/.local/go \
        || down_load ${BASE_URL_2}/go${GO_VERSION}.darwin-amd64.tar.gz ${HOME}/.local/go
    ;;
    Linux)
        down_load ${BASE_URL_1}/go${GO_VERSION}.linux-amd64.tar.gz ${HOME}/.local/go \
        || down_load ${BASE_URL_2}/go${GO_VERSION}.linux-amd64.tar.gz ${HOME}/.local/go
    ;;
    *)
        echo "Operating system not support."
    ;;
    esac

else
    echo "Machine architecture no support."

fi

