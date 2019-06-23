function kcmd
  kubectl get pod -o=name | fzf | xargs kubectl $argv
end
