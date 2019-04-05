#!/usr/bin/env bash
set -e

for F in config/Trolltech.conf config/vlc/vlc-qt-interface.conf
do
    [[ -e "$F" ]] || {
        echo "No $F found" 1>&2
        exit 1
    }

    [[ -w "$F" ]] && {
        echo "File $F should be read-only to prevent cruft" 1>&2
        exit 1
    }
done

exit 0
