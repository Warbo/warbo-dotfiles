#!/bin/sh

# If abduco isn't running, remove sockets
if ! pgrep abduco
then
    rm -f ~/.abduco/default*nixos
fi

st -e shell &
compton -c &
conkeror &
basket &
emacs &
xmb &
gnome-keyring-daemon &
nm-applet &
xmonad
