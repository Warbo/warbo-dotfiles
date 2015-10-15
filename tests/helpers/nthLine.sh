#!/usr/bin/env bash

# Given a filename of the form "N.suff", we return the Nth line of the cache
# "suff"

DIR=$(dirname "$0")
cd "$DIR"

if IDX=$(./getIndex.sh "$1" "$2")
then
    echo "Found index '$IDX'" >> /dev/stderr
    ./cache.sh "$2" | tail -n"$IDX" | head -n1
else
    echo "Path '$1' not an index of '$2'" >> /dev/stderr
    exit 1
fi
