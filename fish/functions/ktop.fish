function ktop
  set node $argv[1]
  set sortBy $argv[2]
  switch $sortBy
    case cpu
      set sortBy 4
    case mem
      set sortBy 5
    case '*'
      set -e sortBy
  end

  set top (kubectl get pod -o wide --all-namespaces | ag $node | cut -d' ' -f1 | tr '\n' '|')
  set top (echo '"'$top'NAME"')

  if test -z sortBy
    kubectl top pod --containers=true --all-namespaces | ag --nocolor $top
  else
    kubectl top pod --containers=true --all-namespaces | ag --nocolor $top | sort -h -k$sortBy
  end
end
