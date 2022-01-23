#!/bin/bash

LAYOUTS_DIR=~/.config/displayLayouts

function save() {
  echo "$1.sh" > $LAYOUTS_DIR/.current
}

function read() {
  cat $LAYOUTS_DIR/.current | cut -d '.' -f1
}

function run() {
  selection=$1

  echo "running $selection"
  "$LAYOUTS_DIR/$selection".sh

  case $? in
    0)
      save $selection
      ;;
    *)
      notify-send "error"
      ;;
  esac
}

function cycle() {
  current=`read`


  found=false
  for f in $LAYOUTS_DIR/*; do
    if [[ "$f" == *$current.sh ]]; then
      found=true
      continue
    fi

    if [ "$found" = true ]; then
      selection=`basename $f | cut -d "." -f1 `
    fi


    # happens when last file in dir was selected before
    if [ -z "$selection" ]; then
      selection=`ls $LAYOUTS_DIR | head -n1 | cut -d  "." -f1`
    fi

    run $selection
  done
}

function menu() {
  selection=`ls -1 $LAYOUTS_DIR | cut -d '.' -f1 | \
    rofi -dmenu -i \
    -width 6 -lines 4 \
    -font "3270SemiNarrow Nerd Font Mono 20"`

  if [ -z "$selection" ]; then
    exit 0
  fi

  run $selection
}

mode=$1

case $mode in
  cycle)
    cycle
    ;;
  *)
    menu
    ;;
esac
