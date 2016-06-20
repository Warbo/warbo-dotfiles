#!/bin/sh
feh --bg-fill ~/Pictures/Backgrounds/01141_hal9000_1280x1024.jpg
st -e shell -f "Droid Sans Mono" &
compton -c &
conkeror &
basket &
emacs &
xmb &
gnome-keyring-daemon &
nm-applet &
nix-shell -p synergy --run synergys &
xmonad
