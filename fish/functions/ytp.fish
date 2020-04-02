set __ytp_playlists_path ~/.playlists

function ytp

  set command $argv[1]

  set playlist (fd --exclude '*.played' . $__ytp_playlists_path | fzf --height 10% | xargs basename)

  if test -z $playlist
    return
  end

  switch $command
    case "add"
      set link $argv[2]
      __ytp_add $link $playlist
    # case "download" TODO
    # case "playPlaylist" TODO
    # case "replay" TODO
    case "*"
      # set link $argv[1] TODO support ad-hoc play
      # __ytp_play $link $playlist
      __ytp_play $playlist
  end
end

function __ytp_add
  set link $argv[1]
  set playlist $argv[2]
  set playlistFile "$__ytp_playlists_path/$playlist"

  # TODO fix perl title regex so it does not break PS1
  set title (wget -qO- $link | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' \
    | sed 's/&amp;/\&/g' \
    | sed 's/&quot;/\"/g')
  # TODO think about backup when title was not found (like .mp3 link from some podcasts)
  echo "Adding: $title"
  # if not test -r $playlistFile TODO fix this pls...
    # touch $playlistFile
  # end
  echo "$link;$title" >> $playlistFile

  # TODO git add git commit
end

function __ytp_play
  # set link $argv[1]
  set playlist $argv[1]
  set playlistFile "$__ytp_playlists_path/$playlist"

  if test -z $link
    set title (cat $playlistFile | cut -d';' -f2- | sort | fzf | uniq)
    set link (ag -Q --nonumbers $title $playlistFile | cut -d';' -f1)
  end
  if test -z $link
    return
  end

  echo "$link;$title" >> "$playlistFile.played"
  ag -v -Q --nonumbers $link $playlistFile > "$playlistFile.bak"
  mv "$playlistFile.bak" $playlistFile

  echo "Playing: $title"
  mpv --no-border $link > /dev/null 2>&1

  # TODO git add git commit
end
