function currns --description "Copies current time in nanoseconds"
  set ns (date +%s)000000
  echo -n $ns | copy $ns
  echo $ns (set_color brblack)'#copied'
end

function currms --description "Copies current time in miliseconds"
  set ms (date +%s)000
  echo -n $ms | copy $ms
  echo $ms (set_color brblack)'#copied'
end

