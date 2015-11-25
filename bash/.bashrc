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

LSCOLORS='cxgxfxdxbxeggcabagacad'
export LSCOLORS

LS_COLORS='di=32;40:ln=36;40:so=35;40:pi=33;40:ex=31;40:bd=34;46:cd=36;42:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LS_COLORS

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo " (${BRANCH} ${STAT})"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="m${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo "[${bits}]"
    else
        echo ""
    fi
}

export PS1="\[\033[38;5;45m\]\u\[\033[0m\]@\[\033[38;5;228m\]\h\[\033[0m\]:\[\033[38;5;182m\]\w\[\033[38;5;85m\]\`parse_git_branch\`\[\033[0m\] $ "
