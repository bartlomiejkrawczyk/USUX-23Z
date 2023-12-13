#!/bin/bash

usage() {
    echo "Usage: $0 directory" 1>&2
}

signal_exception() {
    local MESSAGE="$1"
    echo "$MESSAGE" 1>&2
    usage
    exit 2
}

if [[ $# != 1 ]]; then
    signal_exception "Wrong number of arguments!"
fi

cp Makefile "$1"
