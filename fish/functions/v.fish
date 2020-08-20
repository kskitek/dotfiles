function v
  if test (count $argv) -gt 0
    vim $argv
  else
    set sessionFile (fd -H .session)
    echo $sessionFile
    if test -n "$sessionFile"
      vim -S .session
    else
      vim
    end
  end
end
