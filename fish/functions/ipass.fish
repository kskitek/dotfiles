function ipass
  cd $INFRA_PATH/k8s
  fd .enc | fzf --preview 'sops -d {}' | xargs sops -d
  # set secretFile (fd .enc | fzf --preview 'sops -d {}' | xargs sops -d)
  # set expr (echo '' | fzf --print-query --preview "sops -d $secretFile | yq {q}")
  # sops -d $secretFile | yq $expr
  # echo "#copied"
  cd -
end
