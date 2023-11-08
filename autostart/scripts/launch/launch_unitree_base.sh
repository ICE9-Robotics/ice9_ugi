#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_unibase" "$1" >> ${HOME}/ICE9/autostart/.log
	echo $1
}

log "Launching unitree_legged_real..."
roslaunch unitree_legged_real real.launch
log "Error! unitree_legged_real exited."
log "Ended."
