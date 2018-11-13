#!/bin/bash
# change file suffix name for batch

# linux shell color support.
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"

showhelp()
{
cat << ENDHELP

usage: ./suffix.sh form-suffix to-suffix
example: change file suffix form *.c to *.txt ==> ./suffix.sh c txt

ENDHELP
}

if [ $# -lt 2 ]; then
    showhelp
    exit 1
fi

oldsuffix=$1
newsuffix=$2
dir=$(eval pwd)

for file in $(ls $dir | grep .${oldsuffix})
    do
        name=$(ls ${file} | cut -d. -f1)
        mv $file ${name}.${newsuffix}
    done
echo -e "${GREEN} change $1 to $2 successd! ${BLACK}"
