#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_reach" "$1" >> ${HOME}/Unitree_GPS_Integration/autostart/.log
	echo $1
}

log "Launching reach_ros..."
while true; do
	roslaunch ice9_unitree reach_ros.launch
	log "Error! reach_ros exited."
	log "Restarting reach_ros..."
	sleep 1
done
log "Ended."
