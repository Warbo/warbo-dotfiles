#!/usr/bin/env bash
set -e

[[ -e config/Trolltech.conf ]] || {
    echo "config/Trolltech.conf not found" 1>&2
    exit 1
}

[[ -w config/Trolltech.conf ]] && {
    echo "config/Trolltech.conf should be read-only to prevent cruft" 1>&2
    exit 1
}

exit 0
