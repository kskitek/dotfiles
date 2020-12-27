#!/bin/bash

# mapping done with the help of:
# - https://github.com/chubin/wttr.in/blob/master/lib/constants.py
# - https://www.nerdfonts.com/cheat-sheet

code=$1
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

echo -ne $icon
