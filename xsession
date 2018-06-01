#!/bin/sh
source "$HOME/.profile"
source "$HOME/.bashrc"
setBg
keys
st -e shell -f "Droid Sans Mono" &
compton -c                       &
xsettingsd                       &
basket                           &
emacsclient -c                   &
xmb                              &
gnome-keyring-daemon             &
nm-applet                        &
pidgin                           &
conkeror                         &
xmonad
