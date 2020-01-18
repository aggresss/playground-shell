#!/usr/bin/env bash
# environment file for cache golang package in repo
set -uv
set -x

BASE_URL="https://dl.google.com/go"
if [ ${1-NoDefine} = "NoDefine" ]; then
    GO_VERSION="1.12.15"
else
    GO_VERSION="$1"
fi
qshell sync ${BASE_URL}/go${GO_VERSION}.linux-amd64.tar.gz repo
qshell sync ${BASE_URL}/go${GO_VERSION}.darwin-amd64.tar.gz repo

