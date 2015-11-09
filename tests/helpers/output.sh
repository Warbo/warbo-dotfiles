#!/usr/bin/env bash

[[ -z "$1" ]] && {
    echo "Please give a script name as argument" >> /dev/stderr
    exit 1
}

NAME=$(basename "$1")
[[ -e "scripts/$NAME" ]] || {
    echo "Could not find 'scripts/$NAME'" >> /dev/stderr
    exit 1
}

echo "CONTENTS OF STDOUT"
cat "results/stdout/$NAME"

echo "CONTENTS OF STDERR"
cat "results/stderr/$NAME"
