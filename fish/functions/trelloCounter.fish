function trelloCounter
  if test -z "$trelloKey" -o -z "$trelloToken" -o -z "$trelloBoardId"
    echo "trelloKey; trelloToken; trelloBoardId are required"
    exit 1
  end

  set key $trelloKey
  set token $trelloToken
  set boardId $trelloBoardId

  set resultFile trello-(date +%d-%m-%Y).csv

  set baseUrl https://api.trello.com/1

  if not set -q lower
    set -x lower 0
  end
  if not set -q upper
    set -x upper 10
  end


  set lists (http $baseUrl/boards/$boardId/lists key==$key token==$token fields==id,name,pos | jq .[$lower:$upper])
  set sprintName (echo $lists | jq .[0].name)
  echo "Fetching $sprintName"

  # TODO maybe this should be a batch query to trello rather than multiple queries

  for listId in (echo $lists | jq .[].id)
    set id (echo $listId | tr -d '"')
    set cards (http $baseUrl/lists/$id/cards key==$key token==$token fields==id,name,idShort | jq -c .[])

    for card in $cards
      set cardId (echo $card | jq .id | tr -d '"')
      set name (echo $card | jq '(.idShort|tostring) + " - " + .name')
      echo $name

      if test (uname) "Darwin"
        set reestimated (echo $name | sed -E '/\|[0-9\.]+\|/!d;s/.*\|([0-9\.]+)\|/\1/' | tr -d \")
      else
        set reestimated (echo $name | sed -e '/\|[0-9\.]+\|/!d;s/.*\|([0-9\.]+)\|/\1/' | tr -d \")
      end
      set pluginData (http $baseUrl/cards/$cardId/pluginData key==$key token==$token | jq .[0].value)
      if test $pluginData = "null"
        test -n "$reestimated"; and echo "$sprintName,$name,,$reestimated" >> $resultFile
        continue
      end
      set original (echo $pluginData | tr -d '\\\\' | tail -c +2 | rev | tail -c +2 | rev | jq .points)
      test -n "$original"; and echo "$sprintName,$name,$original,$reestimated" >> $resultFile
    end
  end

  echo "Saved results in:$resultFile"
end
