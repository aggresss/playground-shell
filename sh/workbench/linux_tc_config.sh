#!/usr/bin/env bash
#
# enp1s0 -> external
# enp2s0 -> internal
#

set -x

export UP_LINK="ifb0"
export DOWN_LINK="enp2s0"

set -e

tc class add dev ${UP_LINK} parent 1:1 classid 1:20 htb rate 20mbit
tc qdisc add dev ${UP_LINK} parent 1:20 handle 20: netem delay 20ms 10ms 25% loss 5% 10%
tc filter add dev ${UP_LINK} protocol ip parent 1: prio 3 u32 match ip dst 192.168.122.1 flowid 1:20

tc class add dev ${DOWN_LINK} parent 1:1 classid 1:20 htb rate 20mbit
tc qdisc add dev ${DOWN_LINK} parent 1:20 handle 20: netem delay 20ms 10ms 25% loss 5% 10%
tc filter add dev ${DOWN_LINK} protocol ip parent 1: prio 3 u32 match ip src 192.168.122.1 flowid 1:20