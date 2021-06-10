#!/usr/bin/env bash

set -e

COMMANDDIR="${PWD}/bin"
COMMAND=$COMMANDDIR/xxx

declare -a ARGS=( \
    "-foo bar" \
    )

PREARGS=""
for ARG in ${ARGS[@]}
do
    PREARGS="$PREARGS $ARG"
done

set -x
${COMMAND} ${PREARGS} $@
set +x
