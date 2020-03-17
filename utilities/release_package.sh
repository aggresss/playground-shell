#!/usr/bin/env bash
# Release package

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
LIGHT="\\033[1m"
INVERT="\\033[7m"

VERSION=$(head -n1 CHANGELOG.md | awk '{print $2}' | xargs echo)
if [ "x${VERSION}" = "x" ]; then
    echo -e "${LIGHT}${RED}No release version has been detected.${NORMAL}"
    exit 1
fi

SOURCE_PATH="${PWD}"
RELEASE_PATH="${PWD}/release/v${VERSION}"

declare -a PLATFORM=( \
    "mips-linux-uclibc-gnu" \
    "arm-hisiv300-linux" \
)

declare -a BUILD_TYPE=( \
    "Release" \
    "Debug" \
)

if [ -d ${RELEASE_PATH} ]; then
    echo -e "${LIGHT}${RED}This release version has been released.${NORMAL}"
    exit 2
else
    mkdir -p ${RELEASE_PATH}
fi

mkdir -p build
cd build

for P in ${PLATFORM[@]}
do
    rm -rf ${P}
    mkdir -p ${P}
    cd ${P}

    for B in ${BUILD_TYPE[@]}
    do
        mkdir -p ${B}
        cd ${B}
        cmake ${SOURCE_PATH} -DCMAKE_BUILD_TYPE=${B} -DCROSS_COMPILE=${P}
        make package
        cp *.tar.gz ${RELEASE_PATH}/
        cd ..
    done

    cd ..
done

cd ..

echo -e "\n${LIGHT}${GREEN}Release version ${VERSION} successful.${NORMAL}\n"
exit 0
