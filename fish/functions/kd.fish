function kd
  set resource $argv[1]
  set len (count argv)
  set name (kubectl get $resource -o=name | fzf --preview "kubectl get {} -o yaml | bat -l yaml --color always")
  echo -n $name | sed -E 's/.*\/(.*)/\1/' | copy
end
