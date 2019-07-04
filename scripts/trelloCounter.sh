#!/bin/fish

set key $trelloKey
set token $trelloToken
set boardId $trelloBoardId

set resultFile file.csv

set baseUrl https://api.trello.com/1

set lists (http $baseUrl/boards/$boardId/lists key==$key token==$token fields==id,name,pos | jq .[0:10])
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

    set pluginData (http $baseUrl/cards/$cardId/pluginData key==$key token==$token | jq .[0].value)
    if test $pluginData = "null"
      continue
    end
    set original (echo $pluginData | tr -d '\\\\' | tail -c +2 | head -c -2 | jq .points)
    set reestimated (echo $name | sed -r '/\|[0-9]+\|/!d;s/.*\|([0-9]+)\|/\1/')
    echo "$sprintName,$name,$original,$reestimated" >> $resultFile
  end
end

echo "Saved results in:$resultFile"
