#!/usr/bin/env bash
set -e

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

function autotools_build()
{
    # Search and display toolchain from ${PATH}
    local find_toolchain_cmd='eval find {${PATH//:/,}} -name *gcc'
    echo -e "${GREEN}"
    eval ${find_toolchain_cmd} | cat -n
    echo -e "${NORMAL}"
    local index_range=$(eval ${find_toolchain_cmd} | sed -n '$=')

    # Select toolchain
    local toolchain_index
    read -p "Input toolchain index: " toolchain_index
    if [ ${toolchain_index} -le ${index_range} ] 2>/dev/null; then
        local toolchain=$(eval ${find_toolchain_cmd} | sed -n "${toolchain_index}p")
    else
        echo -e "${RED}\nIndex error!${NORMAL}\n"
        return 1
    fi

    # Analysis toolchain
    local toolchain_triplet=$(${toolchain} -dumpmachine)
    local toolchain_basename=$(basename ${toolchain})
    if [ "${toolchain_basename}" != gcc ]; then
        local toolchain_prefix=${toolchain_basename%-gcc}
    fi

    # Build
    local prefix_dir="${PWD}/output/${toolchain_triplet}"
    rm -rf ${prefix_dir}
    if [ ! -f configure ]; then
        if [ -f autogen.sh ]; then
            ./autogen.sh
        elif [ -f bootstrap ]; then
            ./bootstrap
        elif [ -f buildconf ]; then
            ./buildconf
        else
            autoreconf -vif
        fi
    fi

    if [ "${toolchain_basename}" != gcc ]; then
        ./configure --host=${toolchain_prefix} --prefix=${prefix_dir} $@
    else
        ./configure --prefix=${prefix_dir} $@
    fi
    make
    make install

    # Clean up
    echo -e "\nSuccessful build on ${GREEN}${prefix_dir}${NORMAL}\n"
}

autotools_build $@

