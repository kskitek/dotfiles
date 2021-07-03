function stopwatch
  set start (date +%s)
  while true
    set now (date +%s)
    set diffSec (math $now - $start)
    set diff (date --utc --date @$diffSec +%H:%M:%S)
    printf "\r$diff"
    sleep 1
  end
end
