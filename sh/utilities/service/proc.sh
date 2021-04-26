#!/bin/bash

ulimit -c unlimited

srvs=(
    "redis"
)
srv_cmds=(
    "redis-server"
)

if [ $# == 0 ]; then
	echo "missing operation"
	exit 1
fi

op=$1
target=$2
script=./service_${op}.sh
services=( "${srvs[@]}" )
service_cmds=( "${srv_cmds[@]}" )
index=0
for service in ${services[@]}
do
	if [ "$target" == "" ] || [ "$target" == "$service" ]; then
		$script $service "${service_cmds[$index]}"
	fi
	index=$(($index+1))
done
