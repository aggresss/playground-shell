#!/usr/bin/env bash
#
# enp1s0 -> external
# enp2s0 -> internal
#

export INF_NAME="enp2s0"

tc qdisc del dev ${INF_NAME} handle ffff: ingress
tc qdisc del dev ifb0 root
tc qdisc del dev ${INF_NAME} root

ip link add dev ifb0 type ifb >/dev/null 2>&1
ip link set dev ifb0 up

set -e

tc qdisc add dev ${INF_NAME} handle ffff: ingress
tc filter add dev ${INF_NAME} parent ffff: protocol ip u32 match u32 0 0 action mirred egress redirect dev ifb0

tc qdisc add dev ifb0 root handle 1: htb default 1
tc class add dev ifb0 parent 1: classid 1:1 htb rate 1Gbit quantum 10000

tc qdisc add dev ${INF_NAME} root handle 1: htb default 1
tc class add dev ${INF_NAME} parent 1: classid 1:1 htb rate 1Gbit quantum 10000

########

tc class add dev ifb0 parent 1:1 classid 1:10 htb rate 10mbit
tc qdisc add dev ifb0 parent 1:10 handle 10: sfq perturb 10
tc filter add dev ifb0 protocol ip parent 1: prio 1 u32 match ip dport 22 0xffff flowid 1:10

tc class add dev ${INF_NAME} parent 1:1 classid 1:10 htb rate 10mbit
tc qdisc add dev ${INF_NAME} parent 1:10 handle 10: sfq perturb 10
tc filter add dev ${INF_NAME} protocol ip parent 1: prio 1 u32 match ip sport 22 0xffff flowid 1:10

echo "tc base successful."