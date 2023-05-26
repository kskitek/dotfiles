function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

  echo -n (set_color cyan)(prompt_pwd)

  set branch (git branch --show-current 2>/dev/null)
  test $status = 0
  and echo -n ' '(set_color yellow)$branch

  __context_square
  __jobs_count
  echo -n (set_color cyan)'λ '
  __context_color
end

function __jobs_count
  set jobs (jobs | wc -l | tr -d ' ')
  echo -n (set_color blue)"[$jobs]"
end

function __context_square
  echo -n ' '

  set k8s (kubectl config current-context)
  echo -n (set_color blue) $k8s' '

  #if test (echo $k8s | grep prod)
  #  echo -n (set_color red)'█'
  #else if test (echo $k8s | grep dev)
  #  echo -n (set_color blue)'█'
  #else if test (echo $k8s | grep test)
  #  echo -n (set_color yellow)'█'
  #else
  #  echo -n (set_color red) $k8s' '
  #end
end

function __context_color
  set k8s (kubectl config current-context)
  if test (echo $k8s | grep prod)
    echo -n (set_color -b brred)
  end
end
