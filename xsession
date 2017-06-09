#!/bin/sh
setBg
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
