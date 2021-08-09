FEATURE="feature/$1"

cd ~/git/KFP_CE/
git pull
git worktree add -b $FEATURE ../$FEATURE

echo "new-session $FEATURE"
tmux new-session -s $FEATURE -d

tmux new-window -n git -t $FEATURE:2 -c ~/git/$FEATURE/ansible

tmux kill-window -t $FEATURE:1
tmux new-window -n vim -t $FEATURE:1 -c ~/git/$FEATURE/ansible

tmux new-window -n playbook -t $FEATURE:3 -c ~/git/$FEATURE/ansible

tmux new-window -n dev12 -t $FEATURE:9 'ssh -A dev12.kfp.avp.ru'
