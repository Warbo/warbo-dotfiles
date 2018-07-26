#!/bin/sh
source "$HOME/.profile"
source "$HOME/.bashrc"
setBg
date '+%s' > /tmp/keys-last-ask
st -e shell -f "Droid Sans Mono" &
compton -c                       &
xsettingsd                       &
basket                           &
emacsclient -c                   &
xmb                              &
gnome-keyring-daemon             &
nm-applet                        &
pidgin                           &
conkeror 1>/dev/null 2>/dev/null &
key_poller                       &
xmonad
