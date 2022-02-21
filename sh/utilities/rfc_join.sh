#!/usr/bin/env bash
# https://www.baeldung.com/linux/join-multiple-lines

if [ ${1:-NOCONFIG} = "NOCONFIG" ]; then
    echo 'please input filename.'
    exit 1
fi

gsed -i ':a; N; $!ba; s/   //g; s/\n\n/\v/g; s/\n/ /g; s/\v/\n/g' $1
gsed -i '/\[Page/d' $1
