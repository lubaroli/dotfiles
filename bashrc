# .bashrc file
# Created by Lucas Barcelos (lucas.barcelos@gmail.com) for personal use.

## -------------------------
## -- 2) Configure prompt --
## -------------------------

function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\e[1;36m\]\u@\h\[\e[1;34m\]\$(parse_git_branch) \[\e[1;33m\]\w \[\e[0m\]"

## -----------------------
## -- 3) Set up aliases --
## -----------------------

# 3.1) Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

# 3.2) Listing, directories, and motion
alias ll="ls -la"
alias la="ls -A"
alias l="ls -C"
alias m='less'
alias ..='cd ..'
alias ...='cd ..;cd ..'
alias md='mkdir'
alias cl='clear'

# 3.3) grep options
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31' # green for matches
