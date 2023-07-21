function v
  if test (count $argv) -gt 0
    nvim $argv
  else
    set sessionFile (fd -H '\.session')
    echo $sessionFile
    if test -n "$sessionFile"
      nvim -S .session
    else
      nvim
    end
  end
end
