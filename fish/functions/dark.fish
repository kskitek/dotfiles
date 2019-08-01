function dark
  set scheme dark
  kitty @ set-colors --all --configured ~/.dotfiles/kitty/pencil-$scheme.conf
  set -U KITTY_SCHEME $scheme
  set -U BAT_THEME ansi-$scheme
end
