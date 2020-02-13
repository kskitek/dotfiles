function kd
  set resource $argv[1]
  set lookingForName $argv[2]

  if test -z $lookingForName
    set name (kubectl get $resource -o=name | fzf --preview "kubectl get {} -o yaml | bat -l yaml --color always")
    set name (echo -n $name | sed -E 's/.*\/(.*)/\1/')
    echo -n "$name" | copy
    kubectl get $resource $name -o yaml | bat -l yaml
  else
    set name (kubectl get $resource | ag $lookingForName | head -n 1 | cut -f 1 -d ' ')
    kubectl get $resource $name -o yaml | bat -l yaml
  end
end
