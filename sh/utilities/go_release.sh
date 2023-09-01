#!/usr/bin/env bash
# Build binary file for multi-platform

# Emulate ksh array
{ setopt KSH_ARRAYS || : ; } 2> /dev/null

[ $# -lt 1 ] && echo -e "\nUsage: `basename ${0}` <output> [package]\n" && exit 1

# GOOS | GOARCH | SUFFIX
declare -a ARRAY=( \
    "linux   amd64 -linux-amd64" \
    "linux   arm64 -linux-arm64" \
    "darwin  amd64 -macos-amd64" \
    "darwin  arm64 -macos-arm64" \
    "windows amd64 -amd64.exe" \
    "windows arm64 -arm64.exe" \
    )

for A in "${ARRAY[@]}"
do
    declare -a RECORD=(${A})
    GOOS_=${RECORD[0]}
    GOARCH_=${RECORD[1]}
    SUFFIX_=${RECORD[2]}
    set -x
    CGO_ENABLED=0 GOOS=${GOOS_} GOARCH=${GOARCH_} go build -o ${1}${SUFFIX_} $2
    set +x
done
