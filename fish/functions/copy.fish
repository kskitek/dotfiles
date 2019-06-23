function copy
  if type -q pbcopy
    pbcopy $argv
    return
  end
  if type -q xclip
    xclip $argv
    return
  end
  if type -q clipboard
    clipboard $argv
    return
  end
end
