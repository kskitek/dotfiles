function newpass
  set numOfChars $argv[1]
  if test -z $numOfChars
    set numOfChars 16
  end
  openssl rand -base64 32 | base64 | head -c $numOfChars | copy
  echo '#copied'
end
