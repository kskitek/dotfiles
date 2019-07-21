set fish_greeting

set -U EDITOR vim

## Golang
set -x GO111MODULE on
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go

## PATH
set -U fish_user_paths /usr/local/bin ~/.scripts ~/.dotfiles/scripts/ $GOPATH/bin $GOROOT/bin

set -x GIT_TERMINAL_PROMPT 1

set -x SOPS_GPG_FP "C2E434269F6AE6EDC89DA93CD8DE6BAEBAC09957"
set -x FZF_DEFAULT_COMMAND 'fd --type f --type l'
set -x FZF_DEFAULT_OPTS "--bind 'ctrl-y:execute-silent(echo {} | copy)+abort'"

## Abbrev
if test -d ~/.config/fish/abbreviations
  for f in ~/.config/fish/abbreviations/*.fish
    . $f
  end
end
