function paste
  if type -q pbpaste
    pbpaste
    return
  end
  if type -q xclip
    xclip -selection clipboard -o
    return
  end
  if type -q clipboard
    cat /dev/clipboard
    return
  end
end
