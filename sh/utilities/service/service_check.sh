#!/bin/bash

WORK_DIR=`pwd`
service=$1

pid_dir=$WORK_DIR/.pid
pid=$pid_dir/$service.pid
if [ ! -f $pid ]; then
	echo "WARN: $service is not running."
	exit 1
fi

tail -n 1 $pid | xargs -I{} ps -f {} > /dev/null 2>&1
if [ $? != 0 ]; then
	echo "FATAL: $service is not running."
	rm $pid
	exit 1
fi

value=`tail -n 1 $pid`
echo "OK: $service is running. pid:[$value]"
