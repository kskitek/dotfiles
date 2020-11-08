set fish_greeting

set -x EDITOR vim

fish_vi_key_bindings

set -x LC_ALL en_US.UTF-8
set -x SHELL /usr/local/bin/fish

# Scheme
set -x KITTY_SCHEME $SCHEME
set -x BAT_THEME ansi-$SCHEME

## Golang
set -x GO111MODULE on
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x GOPRIVATE 'gitlab.com/lerta/*,gitlab.com/cloudthing/*'

## PATH
# set -U fish_user_paths /usr/local/bin ~/.scripts ~/.dotfiles/scripts/ $GOPATH/bin $GOROOT/bin ~/.tools/flutter/bin ~/.dotfiles/scripts/kubetail/kubetail ~/tools/kubetail ~/.cargo/bin ~/tools/**/bin
set -x BC_ENV_ARGS ~/.dotfiles/bc
set -x GIT_TERMINAL_PROMPT 1


set -x SOPS_GPG_FP "C2E434269F6AE6EDC89DA93CD8DE6BAEBAC09957"
set -x FZF_DEFAULT_COMMAND 'rg --files'

## Abbrev
if test -d ~/.config/fish/auto
  for f in ~/.config/fish/auto/*.fish
    . $f
  end
end

set -g fish_user_paths "/usr/local/opt/helm@2/bin" $fish_user_paths

set -x CLOUDSDK_PYTHON /usr/local/Cellar/python@3.8/3.8.6_1/bin/python3

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/kskitek/google-cloud-sdk/path.fish.inc' ]; . '/Users/kskitek/google-cloud-sdk/path.fish.inc'; end
