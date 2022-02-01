WORKING=~/Working

# build three columns
WE_IA=$(tmux new-window -c $WORKING/webext-indieauth -n liana -d -P)
tmux send-keys -t $WE_IA "vi package.json" ENTER
LIANA=$(tmux split-window -c $WORKING/liana -h -l 172 -d -t $WE_IA -P)
tmux send-keys -t $LIANA "vi package.json" ENTER
BROWSER=$(tmux split-window -c $WORKING/liana -h -l 71 -d -t $LIANA -P)
tmux send-keys -t $BROWSER "npm run start:firefox" ENTER

# column one
MP_CLI=$(tmux split-window -c $WORKING/micropub-client-typescript -p 90 -d -t $WE_IA -P)
tmux send-keys -t $MP_CLI "vi package.json" ENTER
MS_CLI=$(tmux split-window -c $WORKING/microsub-client-typescript -p 90 -d -t $MP_CLI -P)
tmux send-keys -t $MS_CLI "vi package.json" ENTER
