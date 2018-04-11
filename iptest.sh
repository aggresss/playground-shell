#!/bin/bash   
# test ip:port is open
# usage: iptest ip port
# or create ip-port.txt file each line format: "ip port"

function nc_test()
{
    nc -w 3 -z $1 $2 > /dev/null 2>&1   
    if [ $? -eq 0 ];then   
        echo -e "$1:$2 -\e[32m OK \e[0m"
    else   
        echo -e "$1:$2 -\e[31m Fail \e[0m"
    fi    
}

function args_from_file()
{
    if [ -f "./ip-ports.txt" ];then
        cat ip-ports.txt | while read line   
        do   
            nc_test ${line}
        done
    else
        exit 1
    fi
}

if [ "X_$1" != "X_" ];then
    target_ip=$1
else
    args_from_file
fi

if [ "X_$2" != "X_" ];then
    target_port=$2
else
    exit 1
fi

target="${target_ip} ${target_port}"
nc_test ${target}
