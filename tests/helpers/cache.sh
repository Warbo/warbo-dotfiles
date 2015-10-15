#!/usr/bin/env bash

# Cache expensive data for an hour, eg. results of find
#
# Usage:
#
#   ./helpers/cache.sh "my-cache-name" < <(my_data_source)
#
# Notes:
#  - The script will store data in paths relative to tests/results/data
#  - You should sendi n data via process substitution, as shown above. If you
#    use a pipeline instead, eg. 'my_data_source | ./helpers/cache.sh "foo"',
#    then you would always have to wait for the data to be generated.
#  - You can share caches by using the same argument; beware unintended sharing!

SCRIPT=$(readlink -f "$0")
HELPERS=$(dirname "$SCRIPT")
TESTS=$(dirname "$HELPERS")

CACHE="$TESTS/results/data/$1"
DIR=$(dirname "$CACHE")

mkdir -p "$DIR"

# Has $CACHE been updated within the last hour?
if [[ -e "$CACHE" ]] && test $(find "$CACHE" -mmin -60)
then
    # Yes, use it
    cat "$CACHE"
else
    # No, take stdin instead
    tee "$CACHE"
fi
