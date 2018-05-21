# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -e /home/chris/.nix-profile/etc/profile.d/nix.sh ]
then
  . /home/chris/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer
export PATH=$PATH:~/desktop_scripts/for_laptop:~/System/Programs/bin

# From http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/
# Emacs ansi-term directory tracking
# track directory, username, and cwd for remote logons
if [ $TERM = eterm-color ]; then
    function eterm-set-cwd {
        $@
        echo -e "\033AnSiTc" $(pwd)
    }

    # set hostname, user, and cwd
    function eterm-reset {
        echo -e "\033AnSiTu" $(whoami)
        echo -e "\033AnSiTc" $(pwd)
        echo -e "\033AnSiTh" $(hostname)
    }

    for temp in cd pushd popd; do
        alias $temp="eterm-set-cwd $temp"
    done

    # set hostname, user, and cwd now
    eterm-reset
fi
