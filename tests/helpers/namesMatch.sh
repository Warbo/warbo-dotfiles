#!/usr/bin/env bash
echo "No name given, check names match up"
PREFIX="$1"
while read -r LINE
do
    GOT=$(./helpers/mkName.sh "$LINE")
    echo "Looking for test for '$LINE'"
    FILE="$PREFIX.$GOT"
    [[ -e "scripts/$FILE" ]] || {
        echo "No such file '$FILE', making it"
        pushd scripts                    &&
            ln -s "$PREFIX" "$FILE"      &&
            popd                         &&
            touch "results/stdout/$FILE" &&
            touch "results/stderr/$FILE"
    } || exit 1
done
