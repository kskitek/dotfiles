function ms --description "Prints current time from miliseconds copied from clipboard"
  __ms 1000
end

function ns --description "Prints current time from nanoseconds copied from clipboard"
  __ms 1000000
end

function __ms
  set ms (echo (paste)'/'$argv[1] | bc)
  switch (uname)
    case Darwin
      date -r $ms +'%FT%T %Z'
    case '*'
      date -d @$ms +'%FT%T %Z'
  end
end

