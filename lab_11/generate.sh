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

DIRECTORY="$1"

if [[ ! -d "$DIRECTORY" ]]; then
    signal_exception "Provided directory $DIRECTORY does not exist"
fi

if [[ ! -r "$DIRECTORY" ]]; then
    signal_exception "User does not have read persmission for directory $DIRECTORY"
fi

if [[ ! -x "$DIRECTORY" ]]; then
    signal_exception "User does not have execute persmission for directory $DIRECTORY"
fi

cd "$DIRECTORY"

MAIN_FILE=$(grep --include=\*\*.c -RlE '(int|void)\s+main\s*\(' | head -1)

if [[ ! -f "$MAIN_FILE" ]]; then
    signal_exception "Cannot find main file"
fi

cd - >/dev/null

cp Makefile "$DIRECTORY"
