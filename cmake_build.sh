#!/usr/bin/env bash
set -e
# ${DEFAULT_TOOLCHAIN_PREFIX}

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

function cmake_build()
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

    # Create toolchain.cmake file
    if [ "${toolchain}" != "${default_cc}" ]; then
        local cmake_toolchain_file=$(mktemp)
        cat << END > ${cmake_toolchain_file}
# toolchain.cmake file for ${toolchain_triplet}
set(CMAKE_SYSTEM_NAME Linux)
set(TOOLCHAIN_PREFIX ${DEFAULT_TOOLCHAIN_PREFIX})
set(CMAKE_C_COMPILER \${TOOLCHAIN_PREFIX}-${default_cc})
set(CMAKE_CXX_COMPILER \${TOOLCHAIN_PREFIX}-${default_cxx})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
END
    fi

    # Launch cmake compile
    local build_dir="build-${toolchain_triplet}"
    rm -rf ${build_dir}
    mkdir -p ${build_dir}
    cd ${build_dir}
    if [ "${toolchain}" = "${default_cc}" ]; then
        cmake .. $@
    else
        cmake .. -DCMAKE_TOOLCHAIN_FILE=${cmake_toolchain_file} $@
    fi
    make

    # Clean up
    rm -rf ${cmake_toolchain_file}
    echo -e "\nSuccessful build on ${GREEN}${build_dir}${NORMAL}\n"
}

cmake_build $@

