#!/bin/sh

CODE=0

# Store our status in "status.txt"
PASSED=0
FAILED=0
FAILURES_COUNT=0

function statusMsg {
    TOTAL=$(( $PASSED + $FAILED ))
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
    FAILURES_COUNT=0
    echo "$FAILURES" | while read LINE
                       do
                           if [ -n "$LINE" ]
                           then
                               FAILURES_COUNT=$(( $FAILURES_COUNT + 1 ))
                           fi
                       done
}

function runOne {
    NAME="$1"
    if [ ! -e "scripts/$NAME" ]
    then
        echo "scripts/$NAME not found, skipping"
        return
    fi
    printf "Running $NAME..."
    if "scripts/$NAME" > "results/$NAME.stdout" 2> "results/$NAME.stderr"
    then
        PASSED=$(( $PASSED + 1))
        status
        echo "PASS"
    else
        CODE=1
        FAILED=$(( $FAILED + 1))
        printf "$NAME\n" >> results/failures
        status
        echo "FAIL"
    fi
}

function runAll {
    (shopt -s nullglob
     for TEST in scripts/*
     do
         NAME=$(basename "$TEST")
         runOne "$NAME"
     done)
}

function runFailures {
    echo "$FAILURES" | while read NAME
                       do
                           if [[ -n "$NAME" ]]
                           then
                               runOne "$NAME"
                           fi
                       done
}

readFailures

if [[ "$FAILURES_COUNT" -eq 0 ]]
then
    echo "No previous failures, running all tests"
    runAll
else
    echo "Previous failures found, retrying them"
    runFailures
fi

exit "$CODE"
