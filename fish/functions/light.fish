function light
  set -e SCHEME
  set -U SCHEME light
  kitty @ set-colors --all --configured ~/.dotfiles/kitty/pencil-$SCHEME.conf
  set -x KITTY_SCHEME $SCHEME
  set -x BAT_THEME ansi-$SCHEME
end
