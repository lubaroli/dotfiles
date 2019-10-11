# .bash_profile file
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

CLICOLOR=1

## -----------------------
## -- 1) Configure PATH --
## -----------------------
PATH="/usr/local/opt/python/libexec/bin/:${PATH}"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## Make sure terminal emulators will source bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc
