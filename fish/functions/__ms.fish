function __ms
  set ms (echo (paste)'/'$argv[1] | bc)
  switch (uname)
    case Darwin
      date -r $ms +'%FT%T %Z'
    case '*'
      date -d @$ms +'%FT%T %Z'
  end
end

