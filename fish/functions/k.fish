function k
  set cmd $argv[1]
  echo $cmd
  switch $cmd
    case "log"
      __log $argv
    case '*'
      __resource $argv
    end
end

function __log
  echo "TODO log"
end

function __resource
  set resource $argv[1]
  set len (count argv)
  set name (kubectl get $resource -o=name | fzf | sed -E 's/.*\/(.*)/\1/')
  echo -n $name | copy
  if test $len -gt 1
    kubectl $argv[2..$len] $name
  end
end
