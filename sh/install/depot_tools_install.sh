#!/usr/bin/env bash
# install depot_tools

# 0x00 Function for envrionment operation
# add new element to environment variable append mode
# $1 enviroment variable
# $2 new element
function env_append() {
    eval local env_var=\$\{${1}\-\}
    local new_element=${2%/}
    if [ -d "$new_element" ] && ! echo $env_var | grep -E -q "(^|:)$new_element($|:)" ; then
        eval export $1="\${$1-}\${$1:+\:}${new_element}"
    fi
}
 
# 0x01 Install depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
env_append PATH ${PWD}/depot_tools

