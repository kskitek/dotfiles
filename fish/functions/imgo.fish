set imgo_gophers devil crazy_eyes reggae panic cry_blood happy hat sunbath happy2 \
  cry happy_rudolf cry2 sleep ears_ feeling_bad happy_pink angry happy_swimming \
  confused sick no scared pearls_pink shocked smart angry2 happy3 wink love \
  dance_pink precious so_happy ok laughing_crying laughing fly space yes confused2 \
  sunbath_pink generics hammer rain first_place welder graduate rocket progress searching \
  gentleman welder_k8s wifi_zombie


function imgo
  set gopher (echo $imgo_gophers | tr ' ' \n | fzf)
  # it test -n $gopher
    __imgo $gopher
  # end
end

function __imgo
  for i in (seq (count $imgo_gophers))
    if test $argv[1] = $imgo_gophers[$i]
      echo -n "https://raw.githubusercontent.com/MariaLetta/free-gophers-pack/master/characters/png/$i.png" | copy
      break
    end
  end
end
