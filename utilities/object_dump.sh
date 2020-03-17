#!/usr/bin/env bash
# Generic symbol file for static file

LIB_PATH="static library directory"

declare -a MODULES=( \
    "xx       libxx.a" \
    "yy       libyy.a" \
    )

for T in "${MODULES[@]}"
do
    declare -a ARRAY=(${T})
    MODULE_NAME=${ARRAY[0]}
    MODULE_FILE=${ARRAY[1]}
    if [ "$1" = "clean" ]; then
        rm -rf ${MODULE_NAME}
        echo "X" ${MODULE_NAME} "X" ${MODULE_FILE} "X"
    else
        echo "|" ${MODULE_NAME} "|" ${MODULE_FILE} "|"
        mkdir -p ${MODULE_NAME}
        cp -f ${LIB_PATH}/${MODULE_FILE} ${MODULE_NAME}/
        cd ${MODULE_NAME}
        ar -x ${MODULE_FILE}
        # export object information
        for O in `ls *.o`
        do
            objdump -t $O > ${O/.o/.objdump.txt}
            # nm $O > ${O/.o/.nm.txt}
        done
        rm -rf ${MODULE_FILE}
        cd ..
    fi

done

