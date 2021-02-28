#!/usr/bin/env bash

# kill all
# $1 process name to kill
function kill_all()
{
    local process_id=$(ps ax | grep -e "[/\ ]$1\$" -e "[/\ ]$1[\ ]" | grep -v grep | awk '{print $1}' | sort -u)
    if [ "x$process_id" != "x" ]; then
        for id in $process_id
        do
            kill -9 $id
        done
        echo -e "PID KILLED:\n${RED}${process_id}${NORMAL}"
    fi
}

kill_all $@

