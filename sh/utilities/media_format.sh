#!/usr/bin/env bash
# Media file format transform
# $1 from
# S2 to

set -e

IFS=$(echo -en "\n\b")

for file in `ls *.$1`
    do  ffmpeg -i "$file" -c:a copy  -c:v copy "`echo ${file%.*}.$2`" && rm -vf "$file"
done
