function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

  echo -n (set_color cyan)(prompt_pwd)

  set branch (git branch --show-current 2>/dev/null)
  test $status = 0
  and echo -n ' '(set_color yellow)$branch

  __lerta_simple_context
  echo -n (set_color cyan)'λ '
end

function __lerta_simple_context
  set k8s (kubectl config current-context)
  switch $k8s
    case lerta-dev
      echo -n ' 🔵'
    case lerta-prod
      echo -n ' 🔴'
    case lerta-test
      echo -n ' 🚧'
    case KC-Mobistyle-Lerta-test2-admin
      echo -n ' 👨‍🚀'
    case KC-Mobistyle-Lerta-prod-admin
      echo -n ' 👨‍🚒'
    case '*'
      echo -n (set_color red)' '$k8s' '
  end
end
