function wm
  set -l color "white"
  set -l position "SouthEast"

  argparse --name=wm 'h/help' 'c/color=?' -- $argv
  or return

  if set -q _flag_color
    set color $_flag_color
  end

  if test -z "$argv[1]"
    for file in (fd '.jpg$' -d 1)
      __wm_file $file $color $position &
    end
  else
    __wm_file $file $color $position
  end
  wait
end

function __wm_file
  set -l inFile $argv[1]
  set -l color $argv[2]
  set -l position $argv[3]

  set -l outDir "out"
  set -l offset "+50+25"

  set -l inFileSplited (string split "." $inFile)
  set -l outName (echo $inFileSplited[1]"_wm."$inFileSplited[2])

  echo "Watermarking $inFile"

  set -l refSignFile "SylwiaSign_$color.png"
  set -l refWidth 4592
  set -l refSignWidth 400

  set inWidth (magick identify -format "%w" $inFile)
  set signWidth (echo "$refSignWidth * $inWidth / $refWidth" | bc)
  convert -geometry $signWidth $refSignFile /tmp/$refSignFile

  # composite -watermark 30% -gravity $position -geometry $offset "/tmp/$refSignFile" "$inFile" "$outDir/$outName"
  composite -dissolve 30% -gravity $position -geometry $offset "/tmp/$refSignFile" "$inFile" "$outDir/$outName"
end
