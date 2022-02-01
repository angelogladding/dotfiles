WORKING=~/Working

# build three columns
CANOPY=$(tmux new-window -c $WORKING/canopy -n canopy -d -P)
tmux select-pane -t $CANOPY -T " canopy "
tmux send-keys -t $CANOPY "vi pyproject.toml" ENTER
US_IA_SRV=$(tmux split-window -c $WORKING/understory-indieauth-server -h -l 172 -d -t $CANOPY -P)
tmux select-pane -t $US_IA_SRV -T " understory indieauth server "
tmux send-keys -t $US_IA_SRV "vi pyproject.toml" ENTER
JOB_QUEUE=$(tmux split-window -c $WORKING/canopy -h -l 71 -d -t $US_IA_SRV -P)
tmux select-pane -t $JOB_QUEUE -T " canopy (job queue) "
tmux send-keys -t $JOB_QUEUE "WEBCTX=dev poetry run loveliness serve" ENTER

# column three
WEB_SERVER=$(tmux split-window -c $WORKING/canopy -p 90 -d -t $JOB_QUEUE -P)
tmux select-pane -t $WEB_SERVER -T " canopy (web server) "
tmux send-keys -t $WEB_SERVER "WEBCTX=dev poetry run web serve canopy:app --port 9000" ENTER
CNPY_PRJCT=$(tmux split-window -c $WORKING/canopy -p 90 -d -t $WEB_SERVER -P -F "#{pane_id}")
tmux select-pane -t $CNPY_PRJCT -T " canopy (project control) "
tmux unbind r
tmux bind r send-keys ,r \\\; send-keys -t $CNPY_PRJCT "poetry update && touch pyproject.toml" ENTER

# column two
US_IA_CLI=$(tmux split-window -c $WORKING/understory-indieauth-client -p 90 -d -t $US_IA_SRV -P)
tmux select-pane -t $US_IA_CLI -T " understory indieauth client "
tmux send-keys -t $US_IA_CLI "vi pyproject.toml" ENTER
US_MP_SRV=$(tmux split-window -c $WORKING/understory-micropub-server -p 90 -d -t $US_IA_CLI -P)
tmux select-pane -t $US_MP_SRV -T " understory micropub server "
tmux send-keys -t $US_MP_SRV "vi pyproject.toml" ENTER
US_TXT_EDTR=$(tmux split-window -c $WORKING/understory-text-editor -p 90 -d -t $US_MP_SRV -P)
tmux select-pane -t $US_TXT_EDTR -T " understory text editor "
tmux send-keys -t $US_TXT_EDTR "vi pyproject.toml" ENTER
US_MS_SRV=$(tmux split-window -c $WORKING/understory-microsub-server -p 90 -d -t $US_TXT_EDTR -P)
tmux select-pane -t $US_MS_SRV -T " understory microsub server "
tmux send-keys -t $US_MS_SRV "vi pyproject.toml" ENTER
US_TXT_RDR=$(tmux split-window -c $WORKING/understory-text-reader -p 90 -d -t $US_MS_SRV -P)
tmux select-pane -t $US_TXT_RDR -T " understory text reader "
tmux send-keys -t $US_TXT_RDR "vi pyproject.toml" ENTER
US_WM=$(tmux split-window -c $WORKING/understory-webmention-endpoint -p 90 -d -t $US_TXT_RDR -P)
tmux select-pane -t $US_WM -T " understory webmention endpoint "
tmux send-keys -t $US_WM "vi pyproject.toml" ENTER
US_WS=$(tmux split-window -c $WORKING/understory-websub-endpoint -p 90 -d -t $US_WM -P)
tmux select-pane -t $US_WS -T " understory websub endpoint "
tmux send-keys -t $US_WS "vi pyproject.toml" ENTER
US_TRACKER=$(tmux split-window -c $WORKING/understory-tracker -p 90 -d -t $US_WS -P)
tmux select-pane -t $US_TRACKER -T " understory personal tracker "
tmux send-keys -t $US_TRACKER "vi pyproject.toml" ENTER

# column one
US=$(tmux split-window -c $WORKING/understory -p 90 -d -t $CANOPY -P)
tmux select-pane -t $US -T " understory "
tmux send-keys -t $US "vi pyproject.toml" ENTER
MF=$(tmux split-window -c $WORKING/microformats-python -p 90 -d -t $US -P)
tmux select-pane -t $MF -T " microformats "
tmux send-keys -t $MF "vi pyproject.toml" ENTER
IA=$(tmux split-window -c $WORKING/indieauth-python -p 90 -d -t $MF -P)
tmux select-pane -t $IA -T " indieauth "
tmux send-keys -t $IA "vi pyproject.toml" ENTER
MP=$(tmux split-window -c $WORKING/micropub-python -p 90 -d -t $IA -P)
tmux select-pane -t $MP -T " micropub "
tmux send-keys -t $MP "vi pyproject.toml" ENTER
MS=$(tmux split-window -c $WORKING/microsub-python -p 90 -d -t $MP -P)
tmux select-pane -t $MS -T " microsub "
tmux send-keys -t $MS "vi pyproject.toml" ENTER
WM=$(tmux split-window -c $WORKING/webmention-python -p 90 -d -t $MS -P)
tmux select-pane -t $WM -T " webmention "
tmux send-keys -t $WM "vi pyproject.toml" ENTER
WS=$(tmux split-window -c $WORKING/websub-python -p 90 -d -t $WM -P)
tmux select-pane -t $WS -T " websub "
tmux send-keys -t $WS "vi pyproject.toml" ENTER
