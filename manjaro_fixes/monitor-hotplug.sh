#!/usr/bin/env bash
set -ex

# This script is run by an associated udev rule 95-monitor-hotplug.rules (which
# should be symlinked into /etc/udev/rules.d/). It will trigger whenever the
# PinePhone's graphics card changes (card1; since card0 is 'virtual').

# The monitor-fixing script takes too long to run as a udev handler, so we made
# it into a systemd service
# Use '-M' to use manjaro user's session, even if we happen to be root. Note
# that using 'sudo -u manjaro' won't work, due to incorrect DBus env vars.
# See: https://unix.stackexchange.com/a/685029/63735
systemctl -M manjaro@ --no-block --user start fix-monitor
