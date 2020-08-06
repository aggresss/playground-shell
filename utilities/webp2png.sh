#!/usr/bin/env bash
# webp 格式文件转换

for file in `ls *.webp`
    do  ffmpeg -i $file `echo ${file%.*}.png`
done
