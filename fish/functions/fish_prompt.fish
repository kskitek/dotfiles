function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

  # Main
  echo -n (set_color cyan)(prompt_pwd)

  test -d .git
  and echo -n ' '(set_color yellow)(git branch --show-current)

  __lerta_simple_context
  echo -n 'λ '
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
    case '*'
      echo -n (set_color red)' '$k8s' '
  end
end
