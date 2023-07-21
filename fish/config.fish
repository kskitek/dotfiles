set fish_greeting

set -x EDITOR nvim

fish_vi_key_bindings

set -x LC_ALL en_US.UTF-8
set -x SHELL /usr/bin/fish

# Scheme
set -x KITTY_SCHEME $SCHEME
set -x BAT_THEME ansi-$SCHEME

## Golang
set -x GO111MODULE on
set -x GOPRIVATE 'gitlab.com/lerta/*,gitlab.com/cloudthing/*,github.com/nobl9/*'
set -x GIT_TERMINAL_PROMPT 1

## PATH
set -U fish_user_paths /usr/local/bin ~/.scripts ~/.dotfiles/scripts/ ~/go/bin ~/.dotfiles/scripts/kubetail/kubetail ~/tools/kubetail ~/.cargo/bin ~/tools/**/bin ~/tools/helm
set -gx PATH $PATH $HOME/.krew/bin

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

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/kskitek/google-cloud-sdk/path.fish.inc' ]; . '/Users/kskitek/google-cloud-sdk/path.fish.inc'; end
