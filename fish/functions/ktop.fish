function ktop
  set node $argv[1]
  set sortBy $argv[2]
  switch $sortBy
    case cpu
      set sortBy 3
    case mem
      set sortBy 4
    case '*'
      set -e sortBy
  end

  set top (kubectl get pod -o wide | ag $node | cut -d' ' -f1 | tr '\n' '|')
  set top (echo '"'$top'NAME"')

  if test -z sortBy
    kubectl top pod --containers=true | ag --nocolor $top
  else
    kubectl top pod --containers=true | ag --nocolor $top | sort -h -k$sortBy
  end
end
