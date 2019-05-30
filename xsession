#!/usr/bin/env bash

# Needed for putting Nix packages in our PATH, etc.
source "$HOME/.profile"
source "$HOME/.bashrc"

# Set up our session, theme, etc.
setBg
compton -c &
xsettingsd &
xmb        &

# Get online, with access to WiFi passwords
gnome-keyring-daemon &
nm-applet            &

# Programs we want available immediately
st -e shell -f "Droid Sans Mono" &
conkeror 1>/dev/null 2>/dev/null &

# Delay these to avoid problems or because they're low priority
{ sleep 40;  keys;    } &
{ sleep 90;  emacsen; } &
{ sleep 300; basket;  } &

# This takes control of the session from now on
xmonad
