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

# Emacs shell-mode sets its TERM to 'dumb', even though it can display colours.
# We detect and override that here.
if echo "$INSIDE_EMACS" | grep -q 'comint'
then
    TERM=xterm-256color
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *color) color_prompt=yes;;
    foot) color_prompt=yes;;
    screen) color_prompt=yes;;
esac

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
    printf '\[$(tput bold)$(tput setaf "%s")\]' "$1"
    shift
    printf '%s' "$*"
    printf '\[$(tput sgr0)\]'
}

# These print their arguments in various colours
red()    { coloured 9 "$@"; }
green()  { coloured 10 "$@"; }
yellow() { coloured 11 "$@"; }
blue()   { coloured 12 "$@"; }
purple() { coloured 13 "$@"; }

calculatePrompt() {
    # We use this to calculate the prompt (PS1 variable). The timeline is as
    # follows:
    #  - Previous command finishes
    #  - Bash substitutes '\X' placeholders into PS1 string (e.g. replacing '\t'
    #    with the current time)
    #  - Bash evaluates that resulting string
    #
    # This order is important, since it means those substituted placeholders
    # cannot be generated during the final evaluation step. In particular, we
    # cannot use PS1='$(calculatePrompt)' (using single quotes to ensure that
    # string is used verbatim, and hence this function is called every time the
    # prompt is evaluated, and not before), since this function will not be able
    # to use those \X placeholders.
    #
    # Instead, this function will be called using the PROMPT_COMMAND variable,
    # which lets us emit \X placeholders. This is particularly important for
    # ensuring non-printable characters (like ANSI colour codes) are wrapped in
    # '\[' and '\]', so that they don't count towards the length of the prompt
    # (otherwise Bash/readline get confused about line-wrapping and scrolling).

    # Indicates the working directory in a machine-readable way (for Emacs). We
    # use $PWD since it's absolute (\w uses abbreviations like ~).
    printf '\[\e]7;file://\h${PWD}\a\]'

    # We'll output ANSI colour codes when this is 'yes'
    local colour="$1"

    # This is the exit code of the previous command. We use an argument, since
    # that's more robust than assuming the $? variable hasn't since changed.
    local success="$2"

    # Show the current datetime, and calculate how long the last command took.
    # The latter uses variables set by PS0 (when a command gets entered). This
    # implementation is based on https://stackoverflow.com/a/66772796/884682
    local time='\D{%T} ($((PS1calc ? \D{%s}-$PS0time : 0))s)${PWD:PS1calc=0:0}'
    if [[ "$colour" = 'yes' ]]
    then
        # We're using colour, so make the timestamp green iff the last command
        # was successful, or red otherwise.
        if [[ "$success" -eq 0 ]]; then
            time=$(green "$time")
        else
            time=$(red "$time")
        fi
    fi
    # Also indicate success/failure without using colour. Failed commands will
    # get an exclamation mark, whilst success will be a normal space (we avoid
    # fancier output like tick/cross emoji, since terminals lacking colour are
    # not likely to implement Unicode!)
    if [[ "$success" -eq 0 ]]
    then
        time+=' '
    else
        time+='!'
    fi
    printf '%s' "$time"

    # Hold-over from Debian's default prompt. Always empty, but no harm done.
    printf '%s' "${debian_chroot:+($debian_chroot)}"

    # Follow a normal user@machine:cwd$ prompt format, with arbitrary colours.

    local username='\u'
    [[ "$colour" = 'yes' ]] && username=$(purple "$USER")
    printf '%s' "$username"

    local host='\h'
    [[ "$colour" = 'yes' ]] && host=$(yellow "$host")
    printf '@%s' "$host"

    local workingDir='\w'
    [[ "$colour" = 'yes' ]] && workingDir=$(blue "$workingDir")
    printf ':%s\$ ' "$workingDir"
}

# Use calculatePrompt in our PROMPT_COMMAND, passing in suitable arguments. Note
# that $color_prompt is hard-coded once, when this bashrc is loaded; whilst the
# previous command's exit code can vary for each prompt.
setPrompt() {
    PS1=$(calculatePrompt "$1" "$?")
}
PROMPT_COMMAND="setPrompt $color_prompt"

# PS0 extracts a substring of length 0 from PS1; as a side-effect it stores
# the current time as epoch seconds to PS0time (no visible output in this case)
PS0='\[${PS1:$((PS0time=\D{%s}, PS1calc=1, 0)):0}\]'
PS0time=0
PS1calc=0

## NOTE: From time to time you may wish to replace $PS1 in your shell. You must
## also replace PROMPT_COMMAND, otherwise setPrompt will overwrite your choice!

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

export XDG_RUNTIME_DIR="/run/user/$(id -u)"

#export PULSE_SERVER=/var/run/pulse/native

#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

#export IPFS_PATH=/var/lib/ipfs/.ipfs

export EDITOR=emacsclient
export VISUAL=emacsclient

#gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
gsettings set sm.puri.phosh app-filter-mode '[]'
