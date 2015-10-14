#!/usr/bin/env bash

# Pass in the argument "full" to keep going after a failure
FULL=0
[[ "x$1" = "xfull" ]] && FULL=1

# Make sure everything in ~/Programming is version controlled
ERR=0
for REPO in /home/chris/Programming/repos/*.git
do
    pushd "$REPO" > /dev/null
    if ! git remote | grep github > /dev/null
    then
        echo "$REPO is not mirrored on GitHub"
        ERR=1
        [[ "$FULL" -eq 1 ]] || exit 1
    fi
    popd > /dev/null
done

exit "$ERR"
