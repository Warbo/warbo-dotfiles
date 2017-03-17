#!/bin/sh
feh --bg-fill ~/Pictures/Backgrounds/01141_hal9000_1280x1024.jpg
st -e shell -f "Droid Sans Mono" &
compton -c                       &
conkeror                         &
basket                           &
emacsclient -c                   &
xmb                              &
gnome-keyring-daemon             &
nm-applet                        &
pidgin                           &
xmonad
