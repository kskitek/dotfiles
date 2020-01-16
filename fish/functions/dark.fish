function dark
  set scheme dark
  kitty @ set-colors --all --configured ~/.dotfiles/kitty/pencil-$scheme.conf
  set -e KITTY_SCHEME
  set -U KITTY_SCHEME $scheme
  set -e BAT_THEME
  set -U BAT_THEME ansi-$scheme
end
