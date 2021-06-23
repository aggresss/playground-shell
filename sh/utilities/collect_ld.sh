#!/usr/bin/env bash
# @author Jagger Yu
# Collect target elf file so file by ldd
#  objdump -p /path/to/program | grep NEEDED
#  LD_LIBRARY_PATH=./collect_lib ./collect_lib ld-linux.so /path/to/program

function show_usage()
{
    echo
    echo "USAGE"
    echo "-----"
    echo
    echo "  LIB_DIR=./collect_lib ./collect_ld.sh /path/to/program"
    echo
}

if [ ${1:-NOCONFIG} = "NOCONFIG" ]; then
    >&2 echo "ERROR: With an application as target"
    show_usage
    exit 1
fi

if [ "$(command -v ldd)" == "" ] ; then
    >&2 echo "ERROR: ldd command not found"
    exit 1
fi

if [ -z "${LIB_DIR}" ]; then
    LIB_DIR=${PWD}/collect_lib
fi

if [ ! -d ${LIB_DIR} ]; then
    mkdir -p ${LIB_DIR}
fi

TARGET=$1
LDD_COMMAND=`which ldd`

DEP=`${LDD_COMMAND} -v ${TARGET} | grep ' => /' | sed -r -e 's/^(.*)=> (.*)$/\2/' | awk '{print $1}' | sort | uniq`

for D in ${DEP}
do
    if [ -e $D ]; then
        cp -f $D ${LIB_DIR}/$(basename ${D})
    else
        >&2 echo "ERROR: $D not exist"
    fi
done
