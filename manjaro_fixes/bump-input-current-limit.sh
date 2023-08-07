#!/usr/bin/env bash
set -ex
echo 3000000 | tee /sys/class/power_supply/axp20x-usb/input_current_limit
