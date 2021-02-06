#!/usr/bin/env zsh

function detect_shell_type() {
    echo ${SHELL}
}

function detect_array_start_index() {
    local x=(1 0)
    echo  "Array start index:" ${x[1]}
}

detect_shell_type
detect_array_start_index

