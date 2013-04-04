# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias sl='echo "It is \"ls\", not \"sl\". Slow down, bro."; ls'
alias latest_downloads='ls -t ~/Downloads/ | head '
alias rm="rm -rv"

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

PATH=$PATH:~/.shadowbin
export PATH

function _prompt_get_git_branch {
    $(git symbolic-ref HEAD | cut -d'/' -f3)
}

function _short_pwd {
_dir_abbr=$(temp=$(echo "${PWD/$HOME/~}" |sed -r 's/(\/.)[^/]*/\1/g'); echo ${temp:0:$(( ${#temp} - 1 ))})
   _ps1="$(basename "${PWD/$HOME/~}")"
   if [ ${#_ps1} -gt 25 ]; then
       _ps1="${_ps1:0:7}...${_ps1: -7}"
   fi
   echo -n "$_dir_abbr$_ps1"
}

function _colored_short_dir {
#    if [ \$? = 0 ]; then
#        echo -n "\[\e[33m\]$(_short_pwd)\[\e[0m\]";
#    else
#        echo -n "\[\e[31m\]$(_short_pwd)\[\e[0m\]";
#    fi
    if [ \$? = 0 ]; then echo \[\e[33m\]$(_short_pwd)\[\e[0m\]; else echo \[\e[31m\]$(_short_pwd)\[\e[0m\]; fi
}

function _prompt_old {
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '
    #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
    export PS1
}

function _prompt_cool {
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:`if [ \$? = 0 ]; then echo \[\e[33m\]$(_short_pwd)\[\e[0m\]; else echo \[\e[31m\]$(_short_pwd)\[\e[0m\]; fi` $ '
    export PS1
}

function _prompt_tuna {
    PS1='`if [ \$? = 0 ]; then echo \u@\h\[\e[33m\] $(_short_pwd)\[\e[0m\]; else echo \u@\h\[\e[31m\] $(_short_pwd)\[\e[0m\]; fi`> '
    export PS1
}

function _prompt_tunadir {
    PS1='`if [ \$? = 0 ]; then echo \[\e[33m\]$(_short_pwd)\[\e[0m\]; else echo \[\e[31m\]$(_short_pwd)\[\e[0m\]; fi`> '
    export PS1
}

function _prompt_presentation {
    PS1='$ '
    export PS1
}

function _prompt_block {
    PS1='\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\] '
    export PS1
}

function _prompt_block_short {
    PS1='\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] $(_short_pwd) \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\] '
    export PS1
}

EDITOR=vim
set -o vi

alias upgrade-everything="sudo apt-get update && sudo apt-get dist-upgrade -y --force-yes && notify-send 'Upgrade Complete' 'System is now up-to-date'"

#python ~/.shadowbin/untiltest.py

#_prompt_old
#_prompt_cool
#_prompt_tuna
_prompt_tunadir
#_prompt_block
#_prompt_block2
#_prompt_presentation

source ~/.local/bin/bashmarks.sh
