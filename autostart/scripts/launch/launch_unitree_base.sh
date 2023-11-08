#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_unibase" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}

log "Launching unitree_legged_real..."
while true; do
	roslaunch unitree_legged_real real.launch
	log "Error! unitree_legged_real exited."
	log "Restarting unitree_legged_real..."
	sleep 1
done
log "Ended."
