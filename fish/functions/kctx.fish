function kctx
  kubectl config get-contexts -o name | fzf | xargs kubectl config use-context
end
