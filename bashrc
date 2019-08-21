# .bashrc file
# Created by Lucas Barcelos (lucas.barcelos@gmail.com) for personal use.
#
# Concepts:
#
#    1) .bashrc is the *non-login* config for bash, run in scripts and after
#        first connection.
#    2) .bash_profile is the *login* config for bash, launched upon first
#        connection.
#    3) .bash_profile imports .bashrc, but not vice versa.
#           
# When Bash starts, it executes the commands in a variety of different scripts.
#
#   1) When Bash is invoked as an interactive login shell, it first reads
#      and executes commands from the file /etc/profile, if that file
#      exists. After reading that file, it looks for ~/.bash_profile,
#      ~/.bash_login, and ~/.profile, in that order, and reads and executes
#      commands from the first one that exists and is readable.
#
#   2) When a login shell exits, Bash reads and executes commands from the
#      file ~/.bash_logout, if it exists.
#
#   3) When an interactive shell that is not a login shell is started
#      (e.g. a GNU screen session), Bash reads and executes commands from
#      ~/.bashrc, if that file exists. This may be inhibited by using the
#      --norc option. The --rcfile file option will force Bash to read and
#      execute commands from file instead of ~/.bashrc.

## -------------------------
## -- 2) Configure prompt --
## -------------------------

function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
} 
export PS1="\[\e[1;36m\]\u@\h:\[\e[1;34m\]\$(parse_git_branch) \[\e[1;33m\]\w\\$ \[\e[0m\]"

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
