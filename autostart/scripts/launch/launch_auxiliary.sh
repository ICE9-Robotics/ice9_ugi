#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_auxi" "$1" >> ${HOME}/ice9_ugi/autostart/.log
	echo $1
}

log "Launching unitree_auxiliary..."
while true; do
	roslaunch ice9_unitree unitree_auxiliary.launch
	log "Error! unitree_auxiliary exited."
	log "Restarting unitree_auxiliary..."
	sleep 1
done
log "Ended."
