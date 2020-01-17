function pmdr
  __pmdr &
  disown
end

function __pmdr
  sleep 20m
  __pmdr_notify
  __pmdr_sound
end

function __pmdr_notify
  notify-send "POMIDOR🍅"
end

function __pmdr_sound
  # play comes from SoX
  play -q -n -c1 synth sin %-12 sin %-9 sin %-5 sin %-2 fade h 0.1 1 0.1 2> /dev/null
end
