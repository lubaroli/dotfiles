# .zshrc file
# Created by Lucas Barcelos (lucas.barcelos@gmail.com) for personal use.

export CLICOLOR=1

## -----------------------
## -- 1) Configure PATH --
## -----------------------
PATH="/usr/local/opt/python/libexec/bin/:${PATH}"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## -------------------------
## -- 2) Configure prompt --
## -------------------------

setopt prompt_subst
autoload -U colors && colors
parse_git_branch() {
    ref=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    echo "%B%{$fg[blue]%}$ref%b%{$reset_color%}"
}
PROMPT='%B%{$fg[cyan]%}%n@%m%b$(parse_git_branch) %B%{$fg[yellow]%}%~%b %{$reset_color%}'

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
