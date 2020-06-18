#!/bin/sh
export TERM=xterm-256color

tmux start-server
tmux new-session -s egorf_macpro -d

tmux new-window -n git-vim -t egorf_macpro:1 -c /Users/egorf/tests/vzt-pcs 'vim -p lib/pcs.py'
tmux new-window -n git -t egorf_macpro:2 -c /Users/egorf/tests/vzt-pcs ''
#tmux split-window -h -t egorf_macpro:2 -c /tests-launcher-perf/tests/vzt-pcs/bin 'tail -f log'

tmux select-window -t egorf_macpro:2
tmux attach -t egorf_macpro
