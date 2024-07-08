#/usr/bin/env bash

#
# ip link add dev ifb0 type ifb
#

set -e

INTERFACE_NAME="enp2s0"

tc filter del dev ifb0 root
tc qdisc del dev ifb0 root
tc qdisc del dev ${INTERFACE_NAME} handle ffff: ingress

modprobe ifb numifbs=1
ip link set dev ifb0 up
tc qdisc add dev ${INTERFACE_NAME} handle ffff: ingress
tc filter add dev ${INTERFACE_NAME} parent ffff: protocol ip u32 match u32 0 0 action mirred egress redirect dev ifb0
tc qdisc add dev ifb0 root handle 1:0 htb
tc class add dev ifb0 parent 1: classid 1:1 htb rate 500Mbit
tc class add dev ifb0 parent 1:1 classid 1:10 htb rate 50Mbit
tc qdisc add dev ${INTERFACE_NAME} root handle 1:0 htb
tc class add dev ${INTERFACE_NAME} parent 1: classid 1:1 htb rate 500Mbit
tc class add dev ${INTERFACE_NAME} parent 1:1 classid 1:10 htb rate 50Mbit
