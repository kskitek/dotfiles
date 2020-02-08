function kg
  set resource $argv[1]
  set names $argv[-1..2] # easiest way to get argv[2..]
  set names (echo -n $names | tr ' ' '|')

  if test -z $names
    kubectl get $resource | __color_k8s
  else
    kubectl get $resource | ag "NAME|$names" | __color_k8s
  end
end
