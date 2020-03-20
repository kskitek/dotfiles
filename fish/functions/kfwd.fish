function kfwd
  set target (kubectl get svc,pod --no-headers -o name | fzf)
  switch $target
    case "service*"
      __fwdService $target
    case "pod*"
      __fwdPod $target
  end
end

function __kfwd
  set target $argv[1]
  set targetPort (echo $__fwdTargetPort | cut -d'/' -f1)
  read -l -P "Local port [$targetPort]: " localPort
  if test -z "$localPort"
    set localPort $targetPort
  end
  echo "kubectl port-forward $target $localPort:$targetPort"
  kubectl port-forward $target $localPort:$targetPort
end

function __fwdService
  __getServicePorts $argv
  __kfwd $argv
end

function __fwdPod
  __getPodPorts $argv
  __kfwd $argv
end

function __getServicePorts
  set target $argv[1]
  set -g __fwdTargetPort (kubectl get $target --no-headers | awk '{print $5}' | string split ',' | fzf)
end

function __getPodPorts
  set target $argv[1]
  set -g __fwdTargetPort (kubectl get pod smart-plug-controller-54949fbd5d-fksp2 -o json | jq .spec.containers[].ports[].containerPort | fzf)
end
