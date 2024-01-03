#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_unibase" "$1" >> ${HOME}/ice9_ugi/autostart/.log
	echo $1
}

log "Launching unitree_legged_real..."
while true; do
	roslaunch ice9_unitree unitree_legged_real.launch
	log "Error! unitree_legged_real exited."
	log "Restarting unitree_legged_real..."
	sleep 1
done
log "Ended."
