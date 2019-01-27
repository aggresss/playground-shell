#!/usr/bin/env bash
# environment file for install eclipse
set -e

if [ ${1:-NOCONFIG} = "NOCONFIG" ]; then
    eclipse_version="2018-12"
else
    eclipse_version=$1
fi

base_url="https://mirrors.tuna.tsinghua.edu.cn/eclipse/technology/epp/downloads/release/${eclipse_version}/R/eclipse-cpp-${eclipse_version}-R"

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

    if [ -d $2 ]; then
        rm -rf $2
    fi
    mkdir -p $2

    if [ $file_ext = "gz" -o $file_ext = "bz2" ]; then
        tar -vxf ${down_file} -C $2 --strip-components 1
        rm -rf ${down_file}
    fi
}

if [ $(uname -m) = "x86_64" ]; then
    case $(uname) in
    Linux)
        down_load "${base_url}-linux-gtk-x86_64.tar.gz" ${HOME}/.local/eclipse && \
            rm -rf ${HOME}/bin/eclipse && \
            ln -s ${HOME}/.local/eclipse/eclipse ${HOME}/bin/eclipse
    ;;
    Darwin)
        curl -OL "${base_url}-macosx-cocoa-x86_64.dmg" ${HOME}/Downloads/
    ;;
    *)
        echo "Operating system not support."
    ;;
    esac

else
    echo "Machine architecture no support."

fi

