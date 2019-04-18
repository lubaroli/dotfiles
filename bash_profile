export CLICOLOR=1

PATH="/usr/local/opt/python/libexec/bin/:${PATH}"

export PATH

function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
} 
export PS1="\[\e[1;36m\]\u@\h:\e[1;34m\$(parse_git_branch) \[\033[1;33m\]\w\\$ \[\e[0m\]"
