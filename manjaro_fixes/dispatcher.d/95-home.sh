#!/bin/sh
set -e

[[ "x$(whoami)" = 'xmanjaro' ]] || {
    [[ "x$SWITCHED_USER" = 'x1' ]] && {
        # We set SWITCHED_USER=1 when using sudo below; if it's present, we must
        # have already attempted to switch, but it somehow didn't work. To avoid
        # recursing forever, we just abort.
        echo "Failed to switch from $(whoami) to manjaro, aborting" 1>&2
        exit 2
    }
    echo "Switching from $(whoami) to manjaro" 1>&2
    exec sudo -u manjaro SWITCHED_USER=1 CONNECTION_ID="$CONNECTION_ID" "$0" "$@"
}

# Set env vars to access manjaro's session (which we assume is running...)
DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/1000/bus}"
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/1000}"
export DBUS_SESSION_BUS_ADDRESS
export XDG_RUNTIME_DIR

if getent ahosts dietpi.local > /dev/null
then
    systemctl --user --no-block start dietpi-accessible.target
else
    systemctl --user --no-block stop dietpi-accessible.target
fi

# Find the connection UUID with "nmcli connection show" in terminal.
# All NetworkManager connection types are supported: wireless, VPN, wired...
HOME_ID='VM4163004'

UP=0
if [[ "x$2" = "xup" ]] && [[ "x$CONNECTION_ID" = "x$HOME_ID" ]]
then
    UP=1
else
    if nmcli con show --active | grep -q "$HOME_ID"
    then
        UP=1
    fi
fi

if [[ "$UP" -eq 1 ]]
then
    exec systemctl --user --no-block start home-wifi-connected.target
else
    exec systemctl --user --no-block stop home-wifi-connected.target
fi
