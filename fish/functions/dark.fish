function dark
  set scheme dark
  kitty @ set-colors --all --configured ~/.dotfiles/kitty/pencil-$scheme.conf
  set -x KITTY_SCHEME $scheme
  set -x BAT_THEME ansi-$scheme
end
