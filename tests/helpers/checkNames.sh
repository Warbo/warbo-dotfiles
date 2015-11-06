#!/usr/bin/env bash
NAME="$1"

echo "Checking $NAME" >> /dev/stderr

EXIST=0
while read -r LINE
do
    FOUND=$(./helpers/mkName.sh "$LINE")
    [[ "x$FOUND" = "x$NAME" ]] || continue
    echo "$LINE"
    EXIST=1
done

[[ "$EXIST" -eq 1 ]] || {
    echo "Couldn't find content for '$NAME'" >> /dev/stderr
    exit 1
}
