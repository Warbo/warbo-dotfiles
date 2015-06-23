#!/bin/sh

function exists {
    for S in scripts/*
    do
        NAME=$(basename "$S")
        if [[ "x$NAME" = "x$1" ]]
        then
            return 0
        fi
    done
    return 1
}

# Remove stderr/stdout files which don't correspond to a test
for EXT in stderr stdout
do
    for F in results/*."$EXT"
    do
        NAME=$(basename "$F" ".$EXT")
        if exists "$NAME"
        then
            true
        else
            rm "$F"
        fi
    done
done
