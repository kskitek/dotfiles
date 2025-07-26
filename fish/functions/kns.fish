function kns
  kubectl get ns -o name | cut -d'/' -f2 | fzf | xargs -I {} kubectl config set-context --current --namespace {}
end
