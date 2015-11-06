#!/usr/bin/env bash
BASE=$(basename "$1")
{ echo "$BASE" | grep "\." > /dev/null; } &&
{ echo "$BASE" | cut -d '.' -f 2; }
