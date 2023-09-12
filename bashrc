# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    foot) color_prompt=yes;;
    screen) color_prompt=yes;;
esac
if echo "$INSIDE_EMACS" | grep -q 'comint'
then
    color_prompt=yes
fi


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

coloured() {
    # Prints the given arguments wrapped in ANSI colour codes; except for the
    # first argument, which is the colour code's numeric ID.
    colourCode="$1"
    shift
    printf '\e[%sm%s\e[0m' "$colourCode" "$*"
}

# These print their arguments in various colours
red() { coloured '1;91' "$@"; }
green() { coloured '1;92' "$@"; }
yellow() { coloured '0;93' "$@"; }
blue() { coloured '1;94' "$@"; }
purple() { coloured '0;95' "$@"; }

calculatePrompt() {
    # We use this to calculate the prompt (PS1 variable). The timeline is as
    # follows:
    #  - Previous command finishes
    #  - Bash substitutes '\X' placeholders into PS1 string (e.g. replacing '\t'
    #    with the current time)
    #  - Bash evaluates that resulting string
    #  - This function is called, due to the $(...) subshell
    #
    # This order is important, since it means those substituted placeholders can
    # be passed into this function via arguments; whilst any placeholders we
    # print out will *not* be substituted (since it's too late).

    # This must come first, to capture the exit code of the last command
    local success="$?"
    local chroot="${debian_chroot:+($debian_chroot)}"

    # Show the current time first. This is useful for seeing roughly how long a
    # process took. NOTE: If you want to time a command, make sure you're using
    # a fresh prompt! We also colour the timestamp to indicate whether the last
    # command was successful (green) or failed (red)
    local seconds="$5"
    [[ "$1" = 'mono' ]] || {
        if [[ "$success" -eq 0 ]]; then
            seconds=$(green "$seconds")
        else
            seconds=$(red "$seconds")
        fi
    }

    local username="$2"
    [[ "$1" = 'mono' ]] || username=$(purple "$username")

    local host="$3"
    [[ "$1" = 'mono' ]] || host=$(yellow "$host")

    local workingDir="$4"
    [[ "$1" = 'mono' ]] || workingDir=$(blue "$workingDir")

    printf "$seconds $chroot$username@$host:$workingDir$6 "
}

if [ "$color_prompt" = yes ]; then
    PS1='$(calculatePrompt "color" "\u" "\h" "\w" "\t" "\$")'
else
    PS1='$(calculatePrompt "mono" "\u" "\h" "\w" "\t" "\$")'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Emacs shell-mode should use 'TERM=dumb' to avoid applications attempting to
# use ncurses-like navigation (which won't work), but it still supports colour.
# We spoof 'TERM' for the following applications to make them emit colour.
if [[ "x$TERM" = "xdumb" ]] && [[ -n "$INSIDE_EMACS" ]]
then
    alias ls='TERM=xterm-256color ls --color=auto'
    alias grep='TERM=xterm-256color grep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=~/System/Programs/bin:$HOME/desktop_scripts/for_laptop:$PATH
#export PAGER=pager

export XDG_RUNTIME_DIR=/run/user/1000

#export PULSE_SERVER=/var/run/pulse/native

#export SSH_AUTH_SOCK=/run/user/1000/ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

#export IPFS_PATH=/var/lib/ipfs/.ipfs

export EDITOR=emacsclient
export VISUAL=emacsclient

#gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
gsettings set sm.puri.phosh app-filter-mode '[]'
