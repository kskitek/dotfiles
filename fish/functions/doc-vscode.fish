function doc-vscode
# it has to be a function because abbrev resolves `(pwd)` when `regular.fish`
  docker run -it --rm -p 127.0.0.1:2121:8080 \
    -v ~/.config:/home/coder/.config \
    -v (pwd):/home/coder/project \
    -u (id -u):(id -g) \
    -e DOCKER_USER=$USER \
    codercom/code-server:latest
end
