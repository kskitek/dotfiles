function gtest
  # set patterrn $argv[0]
  while true
    fd .go | entr -d gotest -tags=test ./...
  end
 fd .go | entr -d gotest -tags=test ./...
end
