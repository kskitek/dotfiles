function podenv
  set podRegexp $argv[1]
  set up (string upper $podRegexp)
  kubectl get pod -o name | ag $podRegexp | xargs -I {} kubectl exec {} -- env | ag -v _SERVICE | ag $up
end
