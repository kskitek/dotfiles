# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
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
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[0;94m\]\[$( kubectl config current-context | sed "s/^/k8s: [/" | sed "s/$/]/" )\]\[\033[0m\]\[\033[0;32m\]$( git branch 2> /dev/null | cut -f2 -d\* -s | sed "s/^ / git: [/" | sed "s/$/]/" )\n\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[33;1m\]\w\[\033[0m\] \$ '
PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[0;94m\]\[$( kubectl config current-context | sed "s/^/k8s:[/" | sed "s/$/]/" )\]\[\033[0m\]\[\033[0;32m\]$( git branch 2> /dev/null | cut -f2 -d\* -s | sed "s/^ / git:[/" | sed "s/$/]/" ) \[\033[33;1m\]\w\[\033[0m\]\n λ '

## Exports
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.scripts:~/.scripts/FlameGraph
export PATH=/home/krzysztof/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

export GO111MODULE=on
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export GIT_TERMINAL_PROMPT=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export $EDITOR vim

#export SOPS_GPG_FP=“C2E434269F6AE6EDC89DA93CD8DE6BAEBAC09957”


## Aliases
mkcd ()
{
	mkdir -p "$1"
	cd -P "$1"
}

### Docker aliases
#alias doc-puml="docker run -d --rm -p 8099:8080  plantuml/plantuml-server:jetty && echo http://localhost:8099"
alias doc-puml="docker run -d --rm -p 12130:8080 plantuml/plantuml-server:tomcat"
alias doc-cadvisor="sudo docker run --rm -d --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8090:8080  google/cadvisor:latest && echo http://localhost:8090"
alias doc-wf="docker run -p 8080:8080 -p 9990:9990 kskitek/wildfly_dev"

### Utility aliases
alias srv="python -m SimpleHTTPServer 8000"

alias cd..='cd ..'
alias ll='ls -lah'
alias lls='ls -lah | sort -h -k5'
#alias ls=exa
alias c="xclip -sel clip"
alias k=kubectl
alias watch='watch '
alias o='vim `fzf`'

### K8s aliases
alias krestarts="kubectl get pod --sort-by=.status.containerStatuses[0].restartCount"
alias kstarts='kubectl get pod --sort-by=.status.startTime'
alias kstarted="kubectl get pod --sort-by=.status.containerStatuses[0].state.running.startedAt"
alias kpod="kubectl get pod | fzf"
alias klog="kubectl get pod -o=name | fzf | xargs kubectl logs -f"

### Programming aliases
alias golist="go list -f ‘{{ join .Imports \“\n\” }}’ ./... | sort | uniq"
alias awslogin="aws ecr get-login --region us-east-1 --no-include-email | sh"

alias enter_matrix='echo -e "\e[32m"; while :; do for i in {1..40}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'

### Lerta aliases
alias lprod="kubectl config use-context lerta-prod"
alias ldev="kubectl config use-context lerta-dev"


## Bash options
shopt -s cdspell                 # Correct cd typos
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s extglob                 # Extended pattern
shopt -s no_empty_cmd_completion # No empty completion
# don't put duplicate lines or lines starting with space in the history. See bash(1) for more options
HISTCONTROL=ignoreboth


## Completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
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
if [ -f '/home/krzysztof/.gcloud/completion.bash.inc' ]; then source '/home/krzysztof/.gcloud/completion.bash.inc'; fi
source <(kubectl completion bash)

## Misc tools
. ~/.dotfiles/z/z.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

