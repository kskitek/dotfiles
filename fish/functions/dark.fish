function dark
  set -e SCHEME
  set -U SCHEME dark
  kitty @ set-colors --all --configured ~/.dotfiles/kitty/pencil-$SCHEME.conf
  set -x KITTY_SCHEME $SCHEME
  set -x BAT_THEME ansi-$SCHEME

  set -U fish_color_normal normal
  set -U fish_color_command 009999
  set -U fish_color_quote 5CCCCC
  set -U fish_color_redirection BF7130
  set -U fish_color_end FFB273
  set -U fish_color_error FF7400
  set -U fish_color_param 33CCCC
  set -U fish_color_comment FF9640
  set -U fish_color_match --background=brblue
  set -U fish_color_selection white --bold --background=brblack
  set -U fish_color_search_match bryellow --background=brblack
  set -U fish_color_history_current --bold
  set -U fish_color_operator 00a6b2
  set -U fish_color_escape 00a6b2
  set -U fish_color_cwd green
  set -U fish_color_cwd_root red
  set -U fish_color_valid_path --underline
  set -U fish_color_autosuggestion 006363
  set -U fish_color_user brgreen
  set -U fish_color_host normal
  set -U fish_color_cancel -r
  set -U fish_pager_color_completion normal
  set -U fish_pager_color_description B3A06D yellow
  set -U fish_pager_color_prefix white --bold --underline
  set -U fish_pager_color_progress brwhite --background=cyan
end
