#!/usr/bin/env bash
set -e

# Some influential environment variables:
# DEFAULT_TOOLCHAIN_PREFIX
# CC
# CXX

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
    # evalueate default CC and CXX
    local default_cc
    if [ ${CC:-NOCONFIG} = "NOCONFIG" ]; then
        default_cc="gcc"
    else
        default_cc=${CC}
    fi
    local default_cxx
    if [ ${CXX:-NOCONFIG} = "NOCONFIG" ]; then
        default_cxx="g++"
    else
        default_cxx=${CXX}
    fi

    # evalueate default toolchain prefix
    local toolchain
    if [ "${DEFAULT_TOOLCHAIN_PREFIX:-NOCONFIG}" = "NOCONFIG" ]; then

        # Search and display toolchain from ${PATH}
        local find_toolchain_cmd='eval find {${PATH//:/,}} -name *${default_cc}'
        echo -e "${GREEN}"
        eval ${find_toolchain_cmd} | cat -n
        echo -e "${NORMAL}"
        local index_range=$(eval ${find_toolchain_cmd} | sed -n '$=')

        # Select toolchain
        local toolchain_index
        read -p "Input toolchain index: " toolchain_index
        if [ ${toolchain_index} -le ${index_range} ] 2>/dev/null; then
            toolchain=$(eval ${find_toolchain_cmd} | sed -n "${toolchain_index}p" | xargs basename)
            export DEFAULT_TOOLCHAIN_PREFIX=$(echo "${toolchain}" | sed -e "s/-${default_cc}$//")
        else
            echo -e "${RED}\nIndex error!${NORMAL}\n"
            return 1
        fi
    else
            toolchain=${DEFAULT_TOOLCHAIN_PREFIX}-${default_cc}
    fi

    # Analysis toolchain
    local toolchain_triplet=$(${toolchain} -dumpmachine)

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

