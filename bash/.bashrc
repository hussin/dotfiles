#!/bin/bash
source ~/dotfiles/git/git-completion.bash

if [ -d "$HOME/Library/Python/2.7/bin/" ]; then
    PATH="$HOME/Library/Python/2.7/bin/:$PATH"
    export POWERLINE_COMMAND=powerline
    export POWERLINE_CONFIG_COMMAND=powerline-config
fi

export TERM=xterm-256color

if hash gls 2>/dev/null; then
	alias ls='gls --color'
fi

export CLICOLOR=1
LSCOLORS='cxgxfxdxbxeggcabagacad'
export LSCOLORS

LS_COLORS='di=32;40:ln=36;40:so=35;40:pi=33;40:ex=31;40:bd=34;46:cd=36;42:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LS_COLORS

alias ls='ls -GFh'

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        echo " (${BRANCH})"
    else
        echo ""
    fi
}

function grepthis() {
    grep -rnIG --color  $1 ./
}

alias gr=grepthis

export PS1="\[\033[38;5;45m\]\u\[\033[0m\]@\[\033[38;5;228m\]\h\[\033[0m\]:\[\033[38;5;182m\]\w\[\033[38;5;85m\]\`parse_git_branch\`\[\033[0m\] $ "
