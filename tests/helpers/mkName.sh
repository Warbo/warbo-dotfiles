#!/usr/bin/env bash
echo "$1" | tr 'A-Z' 'a-z' | sed -e 's/[^a-z0-9][^a-z0-9]*/_/g'
