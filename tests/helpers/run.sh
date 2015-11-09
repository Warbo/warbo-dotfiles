#!/usr/bin/env bash

[[ "$#" -eq 0 ]] && {
    echo "Please give at least one test name" >> /dev/stderr
    exit 1
}

# Check that arguments refer to tests
NAMES=()
for ARG in "$@"
do
    # Strip off any path; we want "scripts/foo" to be "foo", since the former is
    # a file, and hence we get tab-completion for free
    NAME=$(basename "$ARG")

    [[ -e "scripts/$NAME" ]] || {
        echo "Could not find 'scripts/$NAME'" >> /dev/stderr
        exit 1
    }

    NAMES+=( "$NAME" )
done

# Force re-execution of tests by deleting previous "pass" files, if any
RESULTS=()
for NAME in "${NAMES[@]}"
do
    RESULT="results/pass/$NAME"
    rm -f "$RESULT"
    RESULTS+=( "$RESULT" )
done

# Run tests (i.e. try to make "pass" files for each)
./run "${RESULTS[@]}"
