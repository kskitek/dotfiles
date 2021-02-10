
if test -f ~/.ssh/agent.env
  . ~/.ssh/agent.env > /dev/null
  #if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
  #    eval `ssh-agent | tee ~/.ssh/agent.env`
  #    ssh-add
  #fi
else
  eval (ssh-agent -c | tee ~/.ssh/agent.env)
  ssh-add
end
