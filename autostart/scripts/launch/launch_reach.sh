#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_reach" "$1" >> ${HOME}/ICE9/autostart/.log
	echo $1
}

log "Launching reach_ros..."
roslaunch ice9_unitree reach_ros.launch
log "Error! reach_ros exited."
log "Ended."
