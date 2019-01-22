#!/usr/bin/env bash
set -e
shopt -s nullglob

function cmake_build()
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
    local toolchain_prefix=${toolchain_basename%-gcc}

    # Create toolchain.cmake file
    local cmake_toolchain_file=$(mktemp)
    cat << END > ${cmake_toolchain_file}
# toolchain.cmake file for ${toolchain_prefix}
set(CMAKE_SYSTEM_NAME Linux)
set(TOOLCHAIN_PREFIX ${toolchain_prefix})
set(CMAKE_C_COMPILER \${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER \${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
END

    # Launch cmake compile
    local build_dir="build-${toolchain_triplet}"
    rm -rf ${build_dir}
    mkdir -p ${build_dir}
    cd ${build_dir}
    cmake .. -DCMAKE_TOOLCHAIN_FILE=${cmake_toolchain_file} $@
    make

    # Clean up
    rm -rf ${cmake_toolchain_file}
}

cmake_build $@

