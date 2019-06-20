#!/usr/bin/env bash
# Export source

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
RELEASE_FILE="sdk-v${VERSION}"

declare -a IGNORE_PATH=( \
    "build" \
    "release" \
    "export_source.sh" \
)

mkdir -p ${RELEASE_PATH}
rm -rf /tmp/${RELEASE_FILE}
mkdir -p /tmp/${RELEASE_FILE}

flag=0
for F in `ls ${PWD}`
do
    for I in ${IGNORE_PATH[@]}
    do
        if [ "${F}" = "${I}" ]; then
            flag=1
            break
        else
            flag=0
        fi
    done
    if [ $flag = 0 ]; then
        cp -rvf ${F} /tmp/${RELEASE_FILE}/
    fi
done

cd /tmp

# rm specify file

tar zcvf ${RELEASE_PATH}/${RELEASE_FILE}-src.tar.gz ${RELEASE_FILE}
rm -rf ${RELEASE_FILE}

echo -e "\n${LIGHT}${GREEN}Export version ${VERSION} source successful.${NORMAL}\n"
exit 0
