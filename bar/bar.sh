#!/bin/bash

BAR_FIFO=/tmp/bar-fifo
#BAR_HEIGHT=20
BAR_FONT="3270SemiNarrow Nerd Font Mono:size=14"

FG=#FFFFFF
BG=#222222
ORANGE="#cf590a"
TEAL="#12947e"

[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

# bspc config top_padding $BAR_HEIGHT

repeat() {
  cmd=$1
  t=$2
  while true
  do
    $cmd > $BAR_FIFO
    sleep $t
  done
}

getcalendar() {
  echo "D$(date '+%A, %d %B')"
}
repeat getcalendar 60 &

getclock() {
	echo "T$(date '+%H:%M:%S')"
}
repeat getclock 1 &

getweather() {
  w=$(http wttr.in/Poznan format==j1 | \
    jq -r '.current_condition[] |
     [.temp_C, .FeelsLikeC, .precipMM, .weatherCode] |
     @csv')
  echo "H$w"
}
repeat getweather 900 &

getkube() {
	echo "K$(kubectl config current-context)"
}
repeat getkube 10 &

getgcp() {
  echo "G$(gcloud config configurations list | grep True | cut -f1 -d' ')"
}
repeat getgcp 10 &

getnotifications() {
  echo "N$(dunstctl is-paused)" > $BAR_FIFO
}
getnotifications &

getvolume(){
  outputDevice=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')
  o=$outputDevice
  case $outputDevice in
    alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-game) outputDevice=headphones ;;
    alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat) outputDevice=headphones ;;
    *) outputDevice=speakers
  esac
  echo "V$(pamixer --get-volume),$(pamixer --get-mute),$outputDevice"
  # simple sleep is better because pactl subscribe floods with events when music is on
}
repeat getvolume 1 &

getwm() {
  bspc subscribe report > $BAR_FIFO
}
getwm &

formatwm() {
  #example wm report: WMDP-0:o1:o2:O3:f4:f5:f6:f7:f8:f9:f10:LT:TT:G
  q=`echo $1 | cut -d':' -f2-11`
  IFS=':' read -r -a array <<< "$q"
  base=63651 # \uf8a3

  # TODO it can be simplified with just mapping 1 to \uf8a3
  wminfo=""
  for index in "${!array[@]}"
  do
    iconOffset=0
    case "${array[index]}" in
      o*) iconOffset=1 ;;
      O*)
        currDesktopIdx=$index
        iconOffset=0
        ;;
      f*) iconOffset=2 ;;
      F*)
        currDesktopIdx=$index
        iconOffset=0
        ;;
    esac
    numberOffset=$((index*3))

    color="-"
    if [ "$currDesktopIdx" = "$index" ]; then
      color="$TEAL+u"
    fi
    iconNr=$((base + iconOffset + numberOffset))
    icon=$(printf "0x%X" $iconNr | tail -c4)
    # TODO I think it should be possible to switch desktop on click
    #  %{A:bspc desktop -f $idx:}$icon%{A}
    # TODO fix 9+ to be 0 (\uf8a0)

    wminfo="$wminfo %{F$color}\u$icon%{F--u}"
  done
}

formatcalendar() {
  # TODO google calendar does not work
  calendar="%{A:~/.dotfiles/bar/calendar.sh:}%{A3:$BROWSER \"https://calendar.google.com\":}\
\uf073 $1\
%{A}%{A}"
}

formatweather() {
  in=$(echo $1 | tr -d '"')
  IFS="," read -r temp feelsLike precip code <<< "$in"

  # mapping done with the help of:
  # - https://github.com/chubin/wttr.in/blob/master/lib/constants.py
  # - https://www.nerdfonts.com/cheat-sheet
  icon=""
  case $code in
    "113") icon="\ufa98" ;;
    "116") icon="\ufa94" ;;
    "119") icon="\ufa8f" ;;
    "122") icon="\ufa8f" ;;
    "143") icon="\ufa90" ;;
    "176") icon="\ufa96" ;;
    "179") icon="\ufb7d" ;;
    "182") icon="\ufb7d" ;;
    "185") icon="\ufb7d" ;;
    "200") icon="\ufb7c" ;;
    "227") icon="\ufa97" ;;
    "230") icon="\ufa97" ;;
    "248") icon="\ufa90" ;;
    "260") icon="\ufa90" ;;
    "263") icon="\ufa96" ;;
    "266") icon="\ufa96" ;;
    "281") icon="\ufb7d" ;;
    "284") icon="\ufb7d" ;;
    "293") icon="\ufa96" ;;
    "296") icon="\ufa96" ;;
    "299") icon="\ufa95" ;;
    "302") icon="\ufa95" ;;
    "305") icon="\ufa95" ;;
    "308") icon="\ufa95" ;;
    "311") icon="\ufb7d" ;;
    "314") icon="\ufb7d" ;;
    "317") icon="\ufb7d" ;;
    "320") icon="\ufa97" ;;
    "323") icon="\ufa97" ;;
    "326") icon="\ufa97" ;;
    "329") icon="\ufa97" ;;
    "332") icon="\ufa97" ;;
    "335") icon="\ufa97" ;;
    "338") icon="\ufa97" ;;
    "350") icon="\ufb7d" ;;
    "353") icon="\ufa96" ;;
    "356") icon="\ufa95" ;;
    "359") icon="\ufa95" ;;
    "362") icon="\ufb7d" ;;
    "365") icon="\ufb7d" ;;
    "368") icon="\ufa97" ;;
    "371") icon="\ufa97" ;;
    "374") icon="\ufb7d" ;;
    "377") icon="\ufb7d" ;;
    "386") icon="\ufb7c" ;;
    "389") icon="\ufb7c" ;;
    "392") icon="\ufa97" ;;
    "395") icon="\ufa97" ;;
  esac
  # TODO on right click open http://wttr.in/Poznań or http://v2.wttr.in/Poznań
  #  show it in the browser or in small floating terminal or using notify-send
  weather="$icon ${temp}/${feelsLike}°C"
}

formatnotifications() {
  case $1 in
    false) notifications="\uf599" ;;
    true) notifications="%{F$ORANGE}\uf59a%{F-}" ;;
  esac
  notifications="%{A:~/.dotfiles/bar/toggleNotifications.sh $BAR_FIFO:}$notifications%{A}"
}

formatkube() {
  echo $1 | grep prod > /dev/null
  isProd=$?
  echo $1 | grep lerta > /dev/null
  isLerta=$?
  if [ "$isProd" -eq 0 ]; then
    kube="\uf1b2 %{B$ORANGE}$1%{B-}"
  elif [ "$isLerta" -eq 0 ]; then
    kube="\uf1b2 %{F$TEAL}$1%{F-}"
  fi
}

formatgcp() {
  echo $1 | grep lerta > /dev/null
  isLerta=$?
  if [ "$isLerta" -eq 0 ]; then
    gcp="\uf1a0 %{F$ORANGE}$1%{F-}"
  else
    gcp="\uf1a0 %{F$TEAL}$1%{F-}"
  fi
}

formatvolume() {
  IFS="," read -r vol muted outputDevice <<< "$1"
  case $outputDevice in
    headphones) volumeIcon="\uf7cb" ;;
    speakers) volumeIcon="\ufc1d" ;;
    *) volumeIcon="\uf028" ;;
  esac

  if [ "$muted" = "true" ]; then
		volume="%{F$ORANGE}\uf466%{F-}"
  else
    volume="$volumeIcon ${vol}%"
  fi

  volume="%{A:~/.dotfiles/bar/selectOutput.sh:}%{A3:pavucontrol &:}\
$volume\
%{A}%{A}"

  # TODO
  # - on scroll pamixer -i/d 5
}

format() {
  power="%{A:~/.dotfiles/bar/powermenu.sh:}\uf011%{A}"

  while IFS= read -r line
  do
    case $line in
      T*) time="\uf017 ${line#?}" ;;
      #D*) calendar="\uf073 ${line#?}" ;;
      D*) formatcalendar "${line#?}" ;;
      H*) formatweather ${line#?} ;;
      K*) formatkube ${line#?} ;;
      G*) formatgcp ${line#?} ;;
      N*) formatnotifications ${line#?} ;;
      V*) formatvolume ${line#?} ;;
      WMDP*) formatwm $line ;;
     esac

    echo -e "%{l} $wminfo" \
      "%{c}$calendar | $time  $weather" \
      "%{r} $gcp $kube | $volume $notifications $power "
  done < $BAR_FIFO
}

killall -q lemonbar
# xdo will keep the bar below fullscreen windows
sleep 1 && xdo above -t $(xdo id -n root) $(xdo id -n lemonbar) &
format | lemonbar -p -F$FG -B$BG -f "$BAR_FONT" | sh

