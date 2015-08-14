#!/usr/bin/env bash

CODE=0

# Store our status in "status.txt"
PASSED=0
FAILED=0
FAILURES_COUNT=0

function statusMsg {
    TOTAL=$(( PASSED + FAILED ))
    if [[ $TOTAL -eq $PASSED ]]
    then
        if [ -z "$FAILURES" ]
        then
            echo "<fc=#00FF00>$FAILED/$TOTAL test failures</fc>"
        else
            echo "<fc=#FF0000>$FAILED/$TOTAL failed so far, $FAILURES_COUNT previously</fc>"
        fi
    else
        echo "<fc=#FF0000>$FAILED/$TOTAL failed so far, $FAILURES_COUNT previously</fc>"
    fi
}

function status {
    statusMsg > status.txt
}

function readFailures {
    # Prioritise failed tests
    mkdir -p results
    if [ -e results/failures ]
    then
        FAILURES=$(cat results/failures)
        rm results/failures.old 2> /dev/null || true
        mv results/failures results/failures.old
    else
        FAILURES=""
    fi
    if [[ -z "$FAILURES" ]]
    then
        FAILURES_COUNT=0
    else
        FAILURES_COUNT=$(echo "$FAILURES" | wc -l)
    fi
}

function runOne {
    NAME="$1"
    if [ ! -e "scripts/$NAME" ]
    then
        echo "scripts/$NAME not found, skipping"
        return
    fi

    # Backup old stdio, so we have something readable during a test run
    for TYP in stdout stderr
    do
        test -e "results/$NAME.$TYP.old" &&
             rm "results/$NAME.$TYP.old"
        test -e "results/$NAME.$TYP"     &&
             mv "results/$NAME.$TYP" "results/$NAME.$TYP.old"
    done

    set +e
    printf "Running %s..." "$NAME"
    if "scripts/$NAME" > "results/$NAME.stdout" 2> "results/$NAME.stderr"
    then
        PASSED=$(( PASSED + 1 ))
        status
        echo "PASS"
    else
        CODE=1
        FAILED=$(( FAILED + 1 ))
        printf "%s\n" "$NAME" >> results/failures
        status
        echo "FAIL, see results/$NAME.stderr and results/$NAME.stdout"
    fi
}

function runAll {
    shopt -s nullglob
    for TEST in scripts/*
    do
        NAME=$(basename "$TEST")
        runOne "$NAME"
    done
}

function runFailures {
    echo "$FAILURES" | sort | while read NAME
                              do
                                  if [[ -n "$NAME" ]]
                                  then
                                      runOne "$NAME"
                                  fi
                              done
}

readFailures

if [[ -z "$FAILURES" ]]
then
    echo "No previous failures, running all tests"
    runAll
else
    echo "Previous failures found, retrying them"
    runFailures
fi

exit "$CODE"
