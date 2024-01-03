#!/bin/bash

log() {
	printf "[%-12.12s]: %s\n" "lch_slam" "$1" >> ${HOME}/ice9_ugi/autostart/.log
	echo $1
}
log "Launching slam_planner_online..."
while true; do
	roslaunch ice9_unitree navigation.launch
	log "Error! slam_planner_online exited."
	log "Restarting slam_planner_online..."
	sleep 1
done
log "Ended."
