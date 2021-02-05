#!/usr/bin/env bash

# Emulate ksh array
{ setopt KSH_ARRAYS || : ; } 2> /dev/null

[ $# -lt 1 ] && echo "Input a domain name" && exit 1

declare -a ARRAY=( \
    "联通      202.106.1.1" \
    "电信      222.222.1.1" \
    "移动      211.138.1.1" \
    )

for A in "${ARRAY[@]}"
do
    declare -a RECORD=(${A})
    TELCOMCOMP=${RECORD[0]}
    SUBNET=${RECORD[1]}
    echo "${TELCOMCOMP}:" `dig +short +subnet=${SUBNET} @119.29.29.29 $1`

done