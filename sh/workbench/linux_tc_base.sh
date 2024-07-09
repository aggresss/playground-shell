#!/usr/bin/env bash
#
# enp1s0 -> external
# enp2s0 -> internal
#

export UP_LINK="ifb0"
export DOWN_LINK="enp2s0"

tc qdisc del dev ${DOWN_LINK} handle ffff: ingress
tc qdisc del dev ${UP_LINK} root
tc qdisc del dev ${DOWN_LINK} root

ip link add dev ${UP_LINK} type ifb >/dev/null 2>&1
ip link set dev ${UP_LINK} up

set -e

tc qdisc add dev ${DOWN_LINK} handle ffff: ingress
tc filter add dev ${DOWN_LINK} parent ffff: protocol ip u32 match u32 0 0 action mirred egress redirect dev ${UP_LINK}

tc qdisc add dev ${UP_LINK} root handle 1: htb default 1
tc class add dev ${UP_LINK} parent 1: classid 1:1 htb rate 1Gbit quantum 10000

tc qdisc add dev ${DOWN_LINK} root handle 1: htb default 1
tc class add dev ${DOWN_LINK} parent 1: classid 1:1 htb rate 1Gbit quantum 10000

########

tc class add dev ${UP_LINK} parent 1:1 classid 1:10 htb rate 10mbit
tc qdisc add dev ${UP_LINK} parent 1:10 handle 10: sfq perturb 10
tc filter add dev ${UP_LINK} protocol ip parent 1: prio 1 u32 match ip dport 22 0xffff flowid 1:10

tc class add dev ${DOWN_LINK} parent 1:1 classid 1:10 htb rate 10mbit
tc qdisc add dev ${DOWN_LINK} parent 1:10 handle 10: sfq perturb 10
tc filter add dev ${DOWN_LINK} protocol ip parent 1: prio 1 u32 match ip sport 22 0xffff flowid 1:10

echo "tc base successful."