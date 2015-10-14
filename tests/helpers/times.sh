#!/usr/bin/env bash

grep -ro "[^ ]*elapsed" results/time           |
sed -e 's/^\([^:]*\):\([^e]*\)elapsed/\2 \1/g' |
sed -e 's@results/time/@scripts/@g'            |
sort
