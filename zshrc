# .zshrc file
# Created by Lucas Barcelos (lucas.barcelos@gmail.com) for personal use.

export CLICOLOR=1

## -------------------------
## -- 1) Configure prompt --
## -------------------------

setopt prompt_subst
autoload -U colors && colors
parse_git_branch() {
    ref=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    echo "%B%{$fg[blue]%}$ref%b%{$reset_color%}"
}
PROMPT='%B%{$fg[cyan]%}%n@%m%b$(parse_git_branch) %B%{$fg[yellow]%}%~%b %{$reset_color%}'

## -----------------------
## -- 2) Set up aliases --
## -----------------------

# 2.1) Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

# 2.2) Listing, directories, and motion
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

## -----------------------
## -- 3) Configure PATH --
## -----------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lubaroli/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lubaroli/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lubaroli/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lubaroli/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Added by the garage installer
export MUJOCO_GL="glfw"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/Users/lubaroli/.mujoco/mujoco200/bin"
