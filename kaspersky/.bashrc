# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
# case "$TERM" in
    # xterm-color) color_prompt=yes;;
# esac
color_prompt=yes

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
    #if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	## We have color support; assume it's compliant with Ecma-48
	## (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	## a case would tend to support setf rather than setaf.)
	#color_prompt=yes
    #else
	#color_prompt=
    #fi
#fi

# https://github.com/jimeh/git-aware-prompt
# https://github.yandex-team.ru/thelamon/git-aware-prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

if [ "$color_prompt" = yes ]; then
    PS1='\n\[\e[1;37m\][$(date +"%Y-%m-%d %H:%M:%S")] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\n\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]$git_branch\[$txtred\]$git_dirty\[$txtrst\]\n\[\e[1;37m\]$\[\e[0;37m\] '
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

    #alias grep='grep --color=auto'
    #alias grep='ack-grep --ignore-dir=".ropeproject"'
    alias grep='ag --ignore-dir=".ropeproject"'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# https://github.com/sharkdp/bat
alias bat='batcat'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# exports
export SVN_EDITOR=vim
export EDITOR=vim

# ssh keys stuff
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# utf
# export LANGUAGE="en_US.UTF-8"
# export LANG="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"

# stderr color
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1



### kaspersky ###
alias play='time ansible-playbook -e vault__token=$VAULT__PRIV_TOKEN'

# vault
export VAULT__SECRET_ID=XXX    # 2021.07.13
export VAULT__PRIV_TOKEN=s.XXX

# proxy settings
export http_proxy=http://127.0.0.1:3128
export https_proxy=http://127.0.0.1:3128

# nexus
export TF_NEXUS_STATE_USERNAME=XXX
export TF_NEXUS_STATE_PASSWORD=XXX

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/fatyushin/yandex-cloud/path.bash.inc' ]; then source '/home/fatyushin/yandex-cloud/path.bash.inc'; fi
# The next line enables shell command completion for yc.
if [ -f '/home/fatyushin/yandex-cloud/completion.bash.inc' ]; then source '/home/fatyushin/yandex-cloud/completion.bash.inc'; fi

function pull_push() {
    if [[ -z "$1" ]]; then
        echo "No image is set"
    else
        image=${1}
        registry_src="kfp-registry...:5002"
        registry_dst="kfpwesteu...:443"

        if [[ -n "$3" ]]; then
            registry_src="$2";
            registry_dst="$3";
        elif [[ -n "$2" ]]; then
            registry_dst="$2";
        fi;

        docker pull "${registry_src}/${image}" && \
        docker tag "${registry_src}/$1" "${registry_dst}/${image}" && \
        docker push "${registry_dst}/${image}"
    fi
}
