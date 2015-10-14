#!/usr/bin/env bash

# Takes two arguments: a script name $1 and a filename suffix $2
# If the script name has the form "foo.$2" then the prefix, in this case "foo",
# is returned. If not, we give a non-zero exit code.
ABS=$(readlink -f "$1")
FILE=$(basename "$ABS")
IDX=$(basename "$FILE" ".$2")
echo "Extracted index '$IDX' from '$1'" >> /dev/stderr

if [[ "x$IDX" = "x$FILE" ]]
then
    echo "'$1' didn't have suffix '$2'" >> /dev/stderr
    exit 1
fi

echo "$IDX"
