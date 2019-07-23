# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set -o vi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## Exports
export PATH=$PATH:~/.scripts:~/.scripts/FlameGraph
export PATH=/home/krzysztof/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:~/.dotfiles/scripts

# golang
export GO111MODULE=on
# export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export GIT_TERMINAL_PROMPT=1

# nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export EDITOR=vim

export SOPS_GPG_FP="C2E434269F6AE6EDC89DA93CD8DE6BAEBAC09957"

## Aliases
pmdr() {
    echo $1*60 | bc | xargs sleep && notify-send "🍅🍅🍅" &&
        [ $(echo -e "y\nn" | dmenu -i -p "PMDR?") == "y" ] && pmdr
}

mkcd () {
	mkdir -p "$1"
	cd -P "$1"
}

### Docker aliases
#alias doc-puml="docker run -d --rm -p 8099:8080  plantuml/plantuml-server:jetty && echo http://localhost:8099"
alias doc-puml="docker run -d --rm -p 12130:8080 plantuml/plantuml-server:tomcat"
alias doc-cadvisor="sudo docker run --rm -d --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8090:8080  google/cadvisor:latest && echo http://localhost:8090"
alias doc-wf="docker run -p 8080:8080 -p 9990:9990 kskitek/wildfly_dev"
alias doc-chrono='docker run -it --rm -p 8888:8888 --net="host" chronograf:1.7.3-alpine'

### Utility aliases
alias srv="python -m SimpleHTTPServer 8000"
alias open="xdg-open"

alias cd..='cd ..'
alias ll='ls -lah'
alias lls='ls -lah | sort -h -k5'
alias c="xclip -sel clip"
alias k=kubectl
alias o='vim `fzf`'
alias v=vim
alias cp="rsync --archive --human-readable --progress --verbose --whole-file"
alias ranger=". ranger"

alias wtr='http -b wttr.in/Poznań?format=3'
alias wtrl='http -b wttr.in | head -n38'

alias br='dlv connect :2345'

### K8s aliases
alias krestarts="kubectl get pod --sort-by=.status.containerStatuses[0].restartCount"
alias kstarts='kubectl get pod --sort-by=.status.startTime'
alias kstarted="kubectl get pod --sort-by=.status.containerStatuses[0].state.running.startedAt"
alias kpod="kubectl get pod | fzf"
alias klog="kubectl get pod -o=name | fzf | xargs kubectl logs -f --tail=200"

alias golist="go list -f '{{ join .Imports \"\n\" }}' ./... | sort | uniq"
alias awslogin="aws ecr get-login --region us-east-1 --no-include-email | sh"

### Lerta aliases
# TODO source alias files dynamically from .dotfiles folder
alias lprod="kubectl config use-context lerta-prod"
alias ldev="kubectl config use-context lerta-dev"

## Bash options
shopt -s cdspell                 # Correct cd typos
shopt -s autocd                  # Auto jump to dir with just a name of a dir (no "cd")
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s extglob                 # Extended pattern
shopt -s no_empty_cmd_completion # No empty completion
# don't put duplicate lines or lines starting with space in the history. See bash(1) for more options
HISTCONTROL=ignoreboth


## Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/krzysztof/.gcloud/path.bash.inc' ]; then source '/home/krzysztof/.gcloud/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/home/krzysztof/.gcloud/completion.bash.inc' ]; then source '/home/krzysztof/.gcloud/completion.bash.inc'; fi
source <(kubectl completion bash)

## Misc tools
. ~/.dotfiles/z/z.sh

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

## Colors

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
unset color_prompt force_color_prompt

alias ls='ls --color=auto'
alias grep='grep --color=auto'

## Coloured man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# ps1() {
    # local k8sContext=$(kubectl config current-context | sed "s/^/k8s:[/" | sed "s/$/]/")
    # local gitBranch=$( git branch 2> /dev/null | cut -f2 -d\* -s | sed "s/^ / git:[/" | sed "s/$/]/" )
    # PS1="\[\033[0;94m\]\[$k8sContext\]\[\033[0m\]\[\033[0;32m\]$gitBranch \[\033[33;1m\]\w\[\033[0m\]\n λ "
# }
# COMMAND_PROMPT=ps1

PS1='\[\033[0;94m\]\[$(  kubectl config current-context | sed "s/^/k8s:[/" | sed "s/$/]/" )\]\[\033[0m\]\[\033[0;32m\]$( git branch 2> /dev/null | cut -f2 -d\* -s | sed "s/^ / git:[/" | sed "s/$/]/" ) \[\033[33;1m\]\w\[\033[0m\]\n λ '

# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

