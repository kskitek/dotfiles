function sctx
  cat ~/.config/nobl9/config.toml |\
    rg 'Contexts\.' |\
    sed -E 's/\s*\[Contexts\.(.*)\]/\1/' |\
    fzf |\
    xargs sloctl use-context
end
