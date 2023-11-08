#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_auxi" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}

log "Launching unitree_auxiliary..."
roslaunch ice9_unitree unitree_auxiliary.launch
log "Error! unitree_auxiliary exited."
log "Ended."
