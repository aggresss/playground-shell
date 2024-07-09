#!/usr/bin/env bash
#
# enp1s0 -> external
# enp2s0 -> internal
#

export INF_NAME="enp2s0"

tc class add dev ifb0 parent 1:1 classid 1:20 htb rate 10mbit
tc qdisc add dev ifb0 parent 1:20 handle 20: netem delay 500ms loss 30%
tc filter add dev ifb0 protocol ip parent 1: prio 3 u32 match ip src 192.168.200.101 flowid 1:20

tc class add dev ${INTERFACE_NAME} parent 1:1 classid 1:20 htb rate 10mbit
tc qdisc add dev ${INTERFACE_NAME} parent 1:20 handle 20: netem delay 500ms loss 30%
tc filter add dev ${INTERFACE_NAME} protocol ip parent 1: prio 3 u32 match ip dst 192.168.200.101 flowid 1:20
