function lpass
  cd $INFRA_PATH/secrets
  set selected (sops -d passwd.json | jq -r '.passwords[] | .name + " ("+ .description +")"' | fzf | tr -d '(' | tr -d ')')
  sops -d passwd.json | jq -r '.passwords[] | .name + " "+ .description +"#" + .password' | ag $selected | cut -d'#' -f2 | tr -d '\n' | copy
  echo "#copied"
  cd -
end
