function newpass
  set numOfChars $argv[1]
  if test -z $numOfChars
    set numOfChars 16
  end
  tr -dc a-zA-Z0-9_#@.- < /dev/urandom | head -c $numOfChars | xclip -selection clipboard
  echo '#copied'
end
