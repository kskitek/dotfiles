abbr -a -- - 'cd -'

abbr -a conf ~/.dotfiles
abbr -a wrk ~/workspace

abbr -a -g doc-puml docker run -d --rm -p 12130:8080 plantuml/plantuml-server:tomcat
abbr -a -g doc-cadvisor sudo docker run --rm -d --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8090:8080  google/cadvisor:latest
abbr -a -g doc-wf docker run -p 8080:8080 -p 9990:9990 kskitek/wildfly_dev
abbr -a -g doc-chrono docker run -it --rm -p 8888:8888 --net="host" chronograf:1.7.3-alpine

abbr -a -g ghub github.com
abbr -a -g glab gitlab.com

alias klog "kubectl get pod -o=name | sed -e 's/pod\///g' | fzf -m | tr \\n , | sed -e 's/,\$//g' | xargs kubetail $argv[1]"

alias cat bat
alias icat "kitty +kitten icat"