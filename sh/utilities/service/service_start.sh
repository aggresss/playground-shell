#!/bin/bash

WORK_DIR=`pwd`
service=$1
cmd=`echo $2 | awk -F ' PORT=' '{print $1}'`
port=`echo $2 | awk -F ' PORT=' '{print $2}'`

pid=$WORK_DIR/.pid/$service.pid
if [ -f $pid ]; then
	tail -n 1 $pid | xargs -I{} ps -f {} > /dev/null 2>&1
	if [ $? == 0 ]; then
		echo "WARN: $service is running."
		exit 1
	fi
fi

$cmd >> $WORK_DIR/run/$service.log 2>&1 &
jobs -p | tail -n 1 > $pid
sleep 0.1
tail -n 1 $pid | xargs -I{} ps -f {} > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "FATAL: start $service failed!"
	exit 1
fi

check=0
while [ "$port" != "" ] && [ $check -lt 10 ]; do
	listen=`lsof -i tcp:$port | grep 'LISTEN' > /dev/null 2>&1`
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 0.5
	check=$(($check+1))
done

tail -n 1 $pid | xargs -I{} echo "INFO: start $service start...pid:["{}"]"
