#!/bin/sh
export TERM=xterm-256color

tmux start-server

tmux new-session -s 00-raccoon -d

tmux new-session -s 01-ipython -d 'ipython'
tmux new-window -n ipython -t 01-ipython:1 'ipython'

tmux new-session -s 02-arcadia -d

tmux new-session -s 03-duty-prod -d

tmux new-session -s 04-rtgraph -d

tmux new-session -s 05-baseage -d

tmux new-session -s BSSERVER-8546-rtgraph-c++ -d

#tmux new-session -s 02-qabs-svn -d
#tmux new-window -n svn -t 02-qabs-svn:1 -c ~/svn/

#tmux new-session -s 03-simulproxy -d
#tmux new-window -n svn -t 03-simulproxy:1 -c ~/svn/qabs-simulproxy-conf/
#tmux new-window -n simulproxy -t 03-simulproxy:2 -c ~/svn/qabs-simulproxy-conf/ 'nissh bscork-simulproxy-bmb.haze.yandex.net'

#tmux new-session -s 04-bsengine -d
#tmux new-window -n bsengine -t 04-bsengine:1 'sh gobsdev.sh'

#tmux new-session -s 05-duty-sandbox -d

#tmux new-session -s 06-duty-bamboo -d

#tmux new-session -s 07-duty-oneshots -d

#tmux new-session -s stage -d

# tmux new-window -n stage-b2b -t stages:2
# tmux new-window -n stage -t stages:3
# tmux new-window -n stage -t stages:4
# tmux select-window -t stages:3
tmux attach -t 00-raccoon
